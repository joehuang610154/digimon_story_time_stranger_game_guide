/// game8.jp 來源。
///
/// 目標頁面：
/// - 全 Digimon 一覧：https://game8.jp/digimonstory-ts/725146
/// - 個別 Digimon 圖鑑：https://game8.jp/digimonstory-ts/{pageId}
///
/// 解析策略：
/// 1. 一覧頁取得每隻 Digimon 的基本資訊（id slug / 名稱 / dex / 種族 / 世代 / タイプ / 性格 / 圖片 / 個別頁 URL）。
/// 2. 個別頁取得 Lv99 ステータス、進化邊（含條件文字 + 結構化條件）、スキル。
///    一覧頁的「進化先」連結僅用來預先檢查 target 是否在表內；實際 edges 從個別頁建構。
library;

import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../http_util.dart';
import '../models.dart';

class Game8Source {
  Game8Source(this.fetcher, {this.detailLimit, this.skipDetails = false});

  final HttpFetcher fetcher;

  /// 個別頁解析的上限（debug / 取樣用，null = 不限）。
  final int? detailLimit;

  /// 完全跳過個別頁（僅做一覧）。
  final bool skipDetails;

  static const indexUrl = 'https://game8.jp/digimonstory-ts/725146';
  static const dlcUrl = 'https://game8.jp/digimonstory-ts/725529';

  /// id → 個別頁 URL。
  final Map<String, String> pageUrls = {};

  /// nameJa → id（個別頁解析合體 partner 性格條件用）。一覧頁解析完成後 populate。
  Map<String, String> _nameToId = {};

  /// 將抓到的資料合併進 [bundle]。
  Future<void> collect(ScrapedBundle bundle) async {
    _seedStats(bundle);

    stdout.writeln('[game8] fetching index $indexUrl ...');
    final indexHtml = await fetcher.fetch(indexUrl);
    final indexDoc = html_parser.parse(indexHtml);
    _parseIndex(indexDoc, bundle);

    _nameToId = {
      for (final d in bundle.digimons.values) d.nameJa: d.id,
    };

    if (skipDetails) {
      stdout.writeln('[game8] --skip-details: 跳過個別頁。');
      return;
    }

    final ids = pageUrls.keys.toList();
    final total = detailLimit != null && detailLimit! < ids.length
        ? detailLimit!
        : ids.length;
    stdout.writeln('[game8] 開始抓個別頁，共 $total 隻 ...');

    var done = 0;
    for (final id in ids.take(total)) {
      final url = pageUrls[id]!;
      try {
        await _parseDetailPage(id, url, bundle);
      } catch (e, st) {
        stderr.writeln('[game8] 解析 $id ($url) 失敗：$e\n$st');
      }
      done++;
      if (done % 25 == 0 || done == total) {
        stdout.writeln('[game8]   進度 $done / $total');
      }
    }

    await _parseDlcPage(bundle);
  }

  // ----- DLC 頁 -----

  Future<void> _parseDlcPage(ScrapedBundle bundle) async {
    stdout.writeln('[game8] fetching DLC page $dlcUrl ...');
    final html = await fetcher.fetch(dlcUrl);
    final doc = html_parser.parse(html);

    var marked = 0;
    final h4s = doc.querySelectorAll('h4');
    for (final h4 in h4s) {
      final h4Text = _cleanText(h4.text);
      if (!h4Text.contains('で追加されたデジモン')) continue;

      final codename = _findDlcCodename(h4);

      Element? cursor = h4.nextElementSibling;
      Element? table;
      while (cursor != null) {
        final ln = cursor.localName;
        if (ln == 'h2' || ln == 'h3' || ln == 'h4') break;
        if (ln == 'table') {
          table = cursor;
          break;
        }
        cursor = cursor.nextElementSibling;
      }
      if (table == null) continue;

      for (final a in table.querySelectorAll('a.a-link')) {
        final href = _absoluteUrl(a.attributes['href']);
        if (href == null || !href.contains('/digimonstory-ts/')) continue;
        final id = _slugFromUrl(href);
        if (id == null) continue;
        final rec = bundle.digimons[id];
        if (rec == null) continue;
        rec.dlcPack = codename ?? h4Text;
        marked++;
      }
    }
    stdout.writeln('[game8] DLC: 標記 $marked 隻');
  }

  /// 在 h4 上一個 h3 之後的 paragraph 中尋找形如「DLC第N弾の「Codename」」的 codename。
  String? _findDlcCodename(Element h4) {
    Element? section = h4.previousElementSibling;
    while (section != null && section.localName != 'h3') {
      section = section.previousElementSibling;
    }
    if (section == null) return null;
    Element? cursor = section.nextElementSibling;
    while (cursor != null && cursor != h4) {
      if (cursor.localName == 'p') {
        final m = RegExp(r'第\d+弾の「([^」]+)」').firstMatch(cursor.text);
        if (m != null) return m.group(1);
      }
      cursor = cursor.nextElementSibling;
    }
    return null;
  }

  // ----- 一覧頁 -----

  void _parseIndex(Document doc, ScrapedBundle bundle) {
    final trList = doc.querySelectorAll('table tbody tr');
    final parsed = <_IndexRow>[];
    for (final tr in trList) {
      final row = _parseIndexRow(tr);
      if (row != null) parsed.add(row);
    }
    final uniqueIds = parsed.map((r) => r.id).toSet().length;
    stdout.writeln(
        '[game8] index: ${parsed.length} rows → $uniqueIds Digimons');

    for (final r in parsed) {
      // 一覧頁可能重複列出同一隻；保留首見並把 dex/imageUrl 補齊。
      final existing = bundle.digimons[r.id];
      if (existing == null) {
        bundle.digimons[r.id] = DigimonRecord(
          id: r.id,
          nameJa: r.nameJa,
          dexNumber: r.dexNumber,
          imageUrl: r.imageUrl,
          sourceUrlJa: r.url,
          stageId: r.stageJa,
          attributeId: r.attrJa,
          typeId: r.typeJa,
          personalityId: r.personalityJa,
        );
      } else {
        existing.dexNumber ??= r.dexNumber;
        existing.imageUrl ??= r.imageUrl;
        existing.sourceUrlJa ??= r.url;
        existing.stageId ??= r.stageJa;
        existing.attributeId ??= r.attrJa;
        existing.typeId ??= r.typeJa;
        existing.personalityId ??= r.personalityJa;
      }

      final attr = r.attrJa;
      if (attr != null && attr.isNotEmpty) {
        bundle.attributes.putIfAbsent(
          attr,
          () => LookupRecord(id: attr, nameJa: attr),
        );
      }
      final stage = r.stageJa;
      if (stage != null && stage.isNotEmpty) {
        bundle.stages.putIfAbsent(
          stage,
          () => LookupRecord(
            id: stage,
            nameJa: stage,
            sortOrder: _stageOrder(stage),
          ),
        );
      }
      final type = r.typeJa;
      if (type != null && type.isNotEmpty) {
        bundle.types.putIfAbsent(
          type,
          () => LookupRecord(id: type, nameJa: type),
        );
      }
      final personality = r.personalityJa;
      if (personality != null && personality.isNotEmpty) {
        bundle.personalities.putIfAbsent(
          personality,
          () => PersonalityRecord(id: personality, nameJa: personality),
        );
      }

      pageUrls[r.id] = r.url;
    }
  }

  _IndexRow? _parseIndexRow(Element tr) {
    final tds = tr.querySelectorAll('td');
    if (tds.length < 2) return null;
    final headTd = tds.first;
    final infoTd = tds[1];

    final headLink = headTd.querySelector('a.a-link');
    if (headLink == null) return null;
    final href = _absoluteUrl(headLink.attributes['href']);
    if (href == null || !href.contains('/digimonstory-ts/')) return null;
    final id = _slugFromUrl(href);
    if (id == null) return null;

    final nameJa = _cleanText(headLink.text);
    if (nameJa.isEmpty) return null;

    final imgUrl = headLink.querySelector('img')?.attributes['data-src'];
    final dexMatch = RegExp(r'【No\.(\d+)】').firstMatch(headTd.text);
    final dexNumber = dexMatch != null ? int.tryParse(dexMatch.group(1)!) : null;
    // 一覧表內也夾雜「ストーリー」「スキル」「装備品」等同站攻略子頁的連結，
    // 它們同樣指向 /digimonstory-ts/，但沒有【No.N】dex 編號。沒 dex 就不是數碼寶貝。
    if (dexNumber == null) return null;

    final grayTags = infoTd.querySelectorAll('span.a-label-tag-gray');
    String? attrJa, stageJa, typeJa, personalityJa;
    if (grayTags.length >= 4) {
      attrJa = _cleanText(grayTags[0].text);
      stageJa = _cleanText(grayTags[1].text);
      typeJa = _cleanText(grayTags[2].text);
      personalityJa = _cleanText(grayTags[3].text);
    }

    return _IndexRow(
      id: id,
      nameJa: nameJa,
      dexNumber: dexNumber,
      imageUrl: imgUrl,
      url: href,
      attrJa: attrJa,
      stageJa: stageJa,
      typeJa: typeJa,
      personalityJa: personalityJa,
    );
  }

  // ----- 個別頁 -----

  Future<void> _parseDetailPage(
    String id,
    String url,
    ScrapedBundle bundle,
  ) async {
    final html = await fetcher.fetch(url);
    final doc = html_parser.parse(html);

    _parseBasicInfo(id, doc, bundle);
    _parseLv99Stats(id, doc, bundle);
    _parseEvolutionsSection(id, doc, bundle);
    _parseSkills(id, doc, bundle);
  }

  /// 解析基本情報表（種族/世代/タイプ/基本性格/デジライド）。一覧頁已大部分覆蓋，這裡補
  /// `can_digiride` 與其它一覧頁沒列的欄位。
  void _parseBasicInfo(String id, Document doc, ScrapedBundle bundle) {
    final rec = bundle.digimons[id];
    if (rec == null) return;
    // 基本情報表是 hl_1 區段第一張 a-table。用通用方式：找包含 `<th>種族</th>` 的 table。
    final tables = doc.querySelectorAll('table.a-table');
    for (final table in tables) {
      final ths = table.querySelectorAll('th');
      if (!ths.any((th) => _cleanText(th.text) == '種族')) continue;
      final rows = table.querySelectorAll('tr');
      for (final tr in rows) {
        final th = tr.querySelector('th');
        final td = tr.querySelectorAll('td').isNotEmpty
            ? tr.querySelectorAll('td').last
            : null;
        if (th == null || td == null) continue;
        final label = _cleanText(th.text);
        final value = _cleanText(td.text);
        if (value.isEmpty) continue;
        switch (label) {
          case '種族':
            rec.attributeId ??= value;
            bundle.attributes.putIfAbsent(
              value,
              () => LookupRecord(id: value, nameJa: value),
            );
            break;
          case '世代':
            rec.stageId ??= value;
            bundle.stages.putIfAbsent(
              value,
              () => LookupRecord(
                id: value,
                nameJa: value,
                sortOrder: _stageOrder(value),
              ),
            );
            break;
          case 'タイプ':
            rec.typeId ??= value;
            bundle.types.putIfAbsent(
              value,
              () => LookupRecord(id: value, nameJa: value),
            );
            break;
          case '基本性格':
            rec.personalityId ??= value;
            bundle.personalities.putIfAbsent(
              value,
              () => PersonalityRecord(id: value, nameJa: value),
            );
            break;
          case 'デジライド':
            // 「○」可、「✕」不可。
            if (value.contains('○') || value == '可') {
              rec.canDigiride = true;
            } else if (value.contains('✕') ||
                value.contains('×') ||
                value == '不可') {
              rec.canDigiride = false;
            }
            break;
        }
      }
      break; // 一頁應只有一個基本情報表。
    }
  }

  /// 解析 Lv99 ステータス 表 → max_hp/.../max_spd。
  void _parseLv99Stats(String id, Document doc, ScrapedBundle bundle) {
    final rec = bundle.digimons[id];
    if (rec == null) return;
    final tables = doc.querySelectorAll('table.a-table');
    for (final table in tables) {
      final ths = table.querySelectorAll('th');
      if (ths.length < 6) continue;
      final headers = ths.map((th) => _cleanText(th.text)).toList();
      // 找有 'HP' 'SP' '攻撃' '防御' 全在內的 row。
      if (!headers.contains('HP') ||
          !headers.contains('SP') ||
          !headers.contains('攻撃')) {
        continue;
      }
      final dataRow = table.querySelectorAll('tr').firstWhere(
        (tr) =>
            tr.querySelectorAll('th').isEmpty &&
            tr.querySelectorAll('td').length == headers.length,
        orElse: () => Element.tag('tr'),
      );
      final tds = dataRow.querySelectorAll('td');
      if (tds.length != headers.length) continue;
      for (var i = 0; i < headers.length; i++) {
        final v = int.tryParse(_cleanText(tds[i].text));
        if (v == null) continue;
        switch (headers[i]) {
          case 'HP':
            rec.maxHp = v;
            break;
          case 'SP':
            rec.maxSp = v;
            break;
          case '攻撃':
            rec.maxAtk = v;
            break;
          case '防御':
            rec.maxDef = v;
            break;
          case '知力':
            rec.maxInt = v;
            break;
          case '精神':
            rec.maxMen = v;
            break;
          case '素早':
            rec.maxSpd = v;
            break;
        }
      }
      break;
    }
  }

  /// 解析 hl_2「進化・退化」section：
  /// - 進化先 tab 的每一 tr 代表「from=自己, to=td1 內 anchor」的進化邊，
  ///   td2 的「進化条件」原文 + 結構化條件。
  /// - 退化 tab 同樣解析為 direction='devolve' 邊。
  void _parseEvolutionsSection(
    String id,
    Document doc,
    ScrapedBundle bundle,
  ) {
    final h2 = doc.querySelector('h2#hl_2');
    if (h2 == null) return;
    // h2 之後找到下一個 tabContainer。最簡單：往 next siblings 找。
    Element? container;
    Element? cursor = h2.nextElementSibling;
    while (cursor != null) {
      if (cursor.classes.contains('a-tabContainer')) {
        container = cursor;
        break;
      }
      // 也有可能 a-tabContainer 是 h2 的 nextSibling 但夾雜其他 element。
      final inner = cursor.querySelector('.a-tabContainer');
      if (inner != null) {
        container = inner;
        break;
      }
      cursor = cursor.nextElementSibling;
    }
    if (container == null) return;

    final tabs = container.querySelectorAll('.a-tab');
    final panels = container.querySelectorAll('.a-tabPanel');
    for (var i = 0; i < panels.length && i < tabs.length; i++) {
      final tabName = _cleanText(tabs[i].text);
      final direction = switch (tabName) {
        '進化先' => 'evolve',
        '退化' => 'devolve',
        _ => null,
      };
      if (direction == null) continue;

      final rows = panels[i].querySelectorAll('table.a-table tr');
      for (final tr in rows) {
        final tds = tr.querySelectorAll('td');
        if (tds.length < 2) continue;
        final targetLink = tds.first.querySelector('a.a-link');
        if (targetLink == null) continue;
        final tHref = targetLink.attributes['href'];
        if (tHref == null) continue;
        final targetId = _slugFromUrl(tHref);
        if (targetId == null) continue;

        final infoTd = tds[1];
        final conditionText = _extractConditionText(infoTd);
        final conditions = _parseConditions(conditionText, bundle);

        bundle.evolutions.add(EvolutionRecord(
          fromId: id,
          toId: targetId,
          direction: direction,
          conditionTextJa: conditionText.isEmpty ? null : conditionText,
          conditions: conditions,
        ));
      }
    }
  }

  /// 從進化 tr 的 infoTd 取「進化条件」/「退化条件」label 之後到 `<hr>` 或下一 label 前的純文字。
  String _extractConditionText(Element infoTd) {
    final buf = StringBuffer();
    var inside = false;
    for (final node in infoTd.nodes) {
      if (node is Element) {
        if (node.localName == 'span' && node.classes.contains('a-label-tag')) {
          final lab = _cleanText(node.text);
          if (lab == '進化条件' || lab == '退化条件') {
            inside = true;
            continue;
          }
          // 遇到「進化先」等其他 label 就停止。
          if (inside) break;
        } else if (node.localName == 'hr') {
          if (inside) break;
        } else if (node.localName == 'br') {
          if (inside) buf.write('\n');
        } else {
          if (inside) buf.write(node.text);
        }
      } else {
        if (inside) buf.write(node.text ?? '');
      }
    }
    return buf
        .toString()
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .join('\n');
  }

  /// 把進化條件原文拆成結構化條件項目。每行為一條。
  List<EvolutionConditionRecord> _parseConditions(String text, ScrapedBundle bundle) {
    if (text.isEmpty || text == 'なし') return const [];
    final result = <EvolutionConditionRecord>[];
    for (final raw in text.split('\n')) {
      final line = raw.trim();
      if (line.isEmpty) continue;
      result.add(_parseConditionLine(line, bundle));
    }
    return result;
  }

  EvolutionConditionRecord _parseConditionLine(String line, ScrapedBundle bundle) {
    // エージェントランクN以上
    final agent = RegExp(r'^エージェントランク(\d+)以上').firstMatch(line);
    if (agent != null) {
      return EvolutionConditionRecord(
        kind: 'agent_rank',
        threshold: int.tryParse(agent.group(1)!),
        textJa: line,
      );
    }
    // 最大HP/SP N 以上
    final maxStat = RegExp(r'^最大(HP|SP)(\d+)以上').firstMatch(line);
    if (maxStat != null) {
      return EvolutionConditionRecord(
        kind: 'stat_min',
        statId: maxStat.group(1)!.toLowerCase(),
        threshold: int.tryParse(maxStat.group(2)!),
        textJa: line,
      );
    }
    // 攻撃力 / 防御力 / 知力 / 精神 / 素早さ N以上
    final stat = RegExp(r'^(攻撃力|防御力|知力|精神|素早さ)(\d+)以上').firstMatch(line);
    if (stat != null) {
      const map = {
        '攻撃力': 'atk',
        '防御力': 'def',
        '知力': 'int',
        '精神': 'men',
        '素早さ': 'spd',
      };
      return EvolutionConditionRecord(
        kind: 'stat_min',
        statId: map[stat.group(1)!],
        threshold: int.tryParse(stat.group(2)!),
        textJa: line,
      );
    }
    // ABI N以上
    final abi = RegExp(r'^ABI[:：]?\s*(\d+)以上').firstMatch(line);
    if (abi != null) {
      return EvolutionConditionRecord(
        kind: 'abi',
        threshold: int.tryParse(abi.group(1)!),
        textJa: line,
      );
    }
    // 戦闘回数 N以上 / 戦闘N回以上
    final battles = RegExp(r'^戦闘(?:回数)?\s*(\d+)\s*回?以上').firstMatch(line);
    if (battles != null) {
      return EvolutionConditionRecord(
        kind: 'battles',
        threshold: int.tryParse(battles.group(1)!),
        textJa: line,
      );
    }
    // LvN以上 / Lv N以上
    final lvl = RegExp(r'^Lv\.?\s*(\d+)以上').firstMatch(line);
    if (lvl != null) {
      return EvolutionConditionRecord(
        kind: 'level',
        threshold: int.tryParse(lvl.group(1)!),
        textJa: line,
      );
    }
    // 「<デジモン名>の性格が<性格>」(含合體 partner 與自己的性格要求)
    final personality =
        RegExp(r'^(.+?)の(?:基本)?性格(?:が|「)([^」]+?)(?:」(?:と.*)?)?$')
            .firstMatch(line);
    if (personality != null) {
      final name = personality.group(1)!;
      final pName = personality.group(2)!;
      final dId = _nameToId[name];
      if (dId != null) {
        bundle.personalities.putIfAbsent(
          pName,
          () => PersonalityRecord(id: pName, nameJa: pName),
        );
        return EvolutionConditionRecord(
          kind: 'personality',
          digimonId: dId,
          personalityId: pName,
          textJa: line,
        );
      }
    }

    return EvolutionConditionRecord(kind: 'special', textJa: line);
  }

  /// 解析 スキル section（hl_3）：スペシャル + アタッチメント。
  void _parseSkills(String id, Document doc, ScrapedBundle bundle) {
    final h2 = doc.querySelector('h2#hl_3');
    if (h2 == null) return;
    // 找 h2 之後的所有 h3 + 表格，分段取得「スペシャル/アタッチメント」。
    Element? cursor = h2.nextElementSibling;
    String? currentCategory;
    while (cursor != null) {
      if (cursor.localName == 'h2') break;
      if (cursor.localName == 'h3') {
        final t = _cleanText(cursor.text);
        if (t.contains('スペシャル')) {
          currentCategory = 'special';
        } else if (t.contains('アタッチメント')) {
          currentCategory = 'attachment';
        } else {
          currentCategory = null;
        }
      } else if (cursor.localName == 'table' && currentCategory != null) {
        _parseSkillTable(id, cursor, currentCategory, bundle);
      }
      cursor = cursor.nextElementSibling;
    }
  }

  /// game8 skill 表結構：
  /// - thead-like tr：`<th>` 內含 element 圖示 + 技能名 anchor
  /// - tbody tr：`<td>` 含 SP / 效果描述
  void _parseSkillTable(
    String digimonId,
    Element table,
    String category,
    ScrapedBundle bundle,
  ) {
    bundle.skillCategories.putIfAbsent(
      category,
      () => LookupRecord(
        id: category,
        nameJa: category == 'special' ? 'スペシャルスキル' : 'アタッチメントスキル',
      ),
    );

    final rows = table.querySelectorAll('tr');
    // 一個 skill 是一對 (th-row, td-row)。
    for (var i = 0; i < rows.length; i++) {
      final r = rows[i];
      final th = r.querySelector('th');
      if (th == null) continue;
      final nameLink = th.querySelector('a.a-link');
      if (nameLink == null) continue;
      final nameJa = _cleanText(nameLink.text);
      final href = nameLink.attributes['href'];
      if (nameJa.isEmpty || href == null) continue;
      final skillId = _slugFromUrl(href);
      if (skillId == null) continue;

      // element 圖：alt="火の画像" / "闇の画像" / ...
      String? elementJa;
      for (final img in th.querySelectorAll('img')) {
        final alt = img.attributes['alt'] ?? '';
        final m = RegExp(r'^(.+?)の画像$').firstMatch(alt);
        if (m != null && m.group(1) != nameJa) {
          elementJa = m.group(1);
          break;
        }
      }
      if (elementJa != null) {
        bundle.elements.putIfAbsent(
          elementJa,
          () => LookupRecord(id: elementJa!, nameJa: elementJa),
        );
      }

      // 下一個 row（同一個技能的 td 內容）
      int? sp;
      String? desc;
      if (i + 1 < rows.length) {
        final next = rows[i + 1];
        if (next.querySelector('th') == null) {
          final td = next.querySelector('td');
          if (td != null) {
            final spMatch =
                RegExp(r'SP[^\d]*(\d+)').firstMatch(_cleanText(td.text));
            if (spMatch != null) sp = int.tryParse(spMatch.group(1)!);
            // 描述：hr 之後到結尾。
            final innerHtml = td.innerHtml;
            final hrIdx = innerHtml.indexOf('<hr');
            if (hrIdx >= 0) {
              final after = innerHtml.substring(hrIdx);
              final descDoc = html_parser.parseFragment(after);
              desc = _cleanText(descDoc.text ?? '');
            } else {
              desc = _cleanText(td.text);
            }
            i++; // 跳過 data row。
          }
        }
      }

      bundle.skills.putIfAbsent(
        skillId,
        () => SkillRecord(
          id: skillId,
          nameJa: nameJa,
          elementId: elementJa,
          categoryId: category,
          spCost: sp,
          descriptionJa: desc,
        ),
      );
      final s = bundle.skills[skillId]!;
      s.elementId ??= elementJa;
      s.categoryId ??= category;
      s.spCost ??= sp;
      s.descriptionJa ??= desc;

      bundle.digimonSkills.add(DigimonSkillLink(
        digimonId: digimonId,
        skillId: skillId,
        acquisition: category, // 'special' / 'attachment'
      ));
    }
  }

  // ----- helpers -----

  String? _slugFromUrl(String url) {
    final m = RegExp(r'/digimonstory-ts/(\d+)').firstMatch(url);
    if (m == null) return null;
    return 'g8_${m.group(1)}';
  }

  String? _absoluteUrl(String? href) {
    if (href == null || href.isEmpty) return null;
    if (href.startsWith('http')) return href;
    if (href.startsWith('/')) return 'https://game8.jp$href';
    return href;
  }

  String _cleanText(String s) =>
      s.replaceAll(' ', ' ').replaceAll(RegExp(r'\s+'), '').trim();

  int? _stageOrder(String ja) {
    const order = {
      '幼年期1': 1,
      '幼年期2': 2,
      '成長期': 3,
      '成熟期': 4,
      '完全体': 5,
      '究極体': 6,
      '超究極体': 7,
      'アーマー体': 8,
      'ハイブリッド体': 9,
      'ハイブリット体': 9, // game8 筆誤版
      'ヴァリアブル': 10,
    };
    return order[ja];
  }

  void _seedStats(ScrapedBundle bundle) {
    const seed = [
      ('hp', 'HP'),
      ('sp', 'SP'),
      ('atk', '攻撃'),
      ('def', '防御'),
      ('int', '知力'),
      ('men', '精神'),
      ('spd', '素早'),
    ];
    for (final (id, ja) in seed) {
      bundle.stats.putIfAbsent(
        id,
        () => StatRecord(id: id, nameJa: ja),
      );
    }
  }
}

class _IndexRow {
  _IndexRow({
    required this.id,
    required this.nameJa,
    required this.url,
    this.dexNumber,
    this.imageUrl,
    this.attrJa,
    this.stageJa,
    this.typeJa,
    this.personalityJa,
  });

  final String id;
  final String nameJa;
  final String url;
  final int? dexNumber;
  final String? imageUrl;
  final String? attrJa;
  final String? stageJa;
  final String? typeJa;
  final String? personalityJa;
}
