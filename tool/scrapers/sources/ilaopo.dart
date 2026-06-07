/// ilaopo.xyz 中文補強 source。
///
/// 目標頁面：
/// - 圖鑑一覽：https://www.ilaopo.xyz/TimeStranger/listM.php
///   每筆格式：`<div class='mon'><a href="evoM.php?id=N">...<p>dex<br>中文名<br>日文名</p></div>`
///
/// 這是一份乾淨的繁體中日對照表，用 game8 已抓到的 `nameJa` 當 join key（完全比對），
/// 比對不到再 fallback 用 `dexNumber`。所以本 source 必須與 game8 在同一次 sync 執行
/// （game8 先把 digimons 灌進 bundle，這裡再補 nameZh）。
library;

import 'dart:io';

import '../http_util.dart';
import '../models.dart';

class IlaopoSource {
  IlaopoSource(this.fetcher);
  final HttpFetcher fetcher;

  static const listUrl = 'https://www.ilaopo.xyz/TimeStranger/listM.php';

  /// 解析單筆：group1=ilaopo 內部 id，group2=dex，group3=中文名，group4=日文名。
  static final _entryRe = RegExp(
    r"<div class='mon'>.*?evoM\.php\?id=(\d+).*?<p>(\d+)<br>([^<]*)<br>([^<]*)</p>",
    dotAll: true,
  );

  Future<void> collect(ScrapedBundle bundle) async {
    if (bundle.digimons.isEmpty) {
      stdout.writeln('[ilaopo] bundle 內沒有 digimons（game8 未先執行？），略過。');
      return;
    }

    final html = await fetcher.fetch(listUrl);
    final entries = _entryRe.allMatches(html).map((m) {
      return (
        ilaopoId: m.group(1)!,
        dex: int.parse(m.group(2)!),
        zh: m.group(3)!.trim(),
        ja: m.group(4)!.trim(),
      );
    }).toList();

    if (entries.isEmpty) {
      stderr.writeln('[ilaopo] ⚠ 解析不到任何 entry，頁面結構可能變了。');
      return;
    }

    // 建 join 索引。
    final byJa = <String, DigimonRecord>{};
    final byDex = <int, DigimonRecord>{};
    for (final d in bundle.digimons.values) {
      byJa[d.nameJa] = d;
      if (d.dexNumber != null) byDex[d.dexNumber!] = d;
    }

    var matched = 0;
    var viaDex = 0;
    final unmatched = <String>[];
    for (final e in entries) {
      var target = byJa[e.ja];
      if (target == null) {
        target = byDex[e.dex];
        if (target != null) viaDex++;
      }
      if (target == null) {
        unmatched.add('#${e.dex} ${e.zh} / ${e.ja}');
        continue;
      }
      target.nameZh = e.zh;
      target.sourceUrlZh =
          'https://www.ilaopo.xyz/TimeStranger/evoM.php?id=${e.ilaopoId}';
      matched++;
    }

    final filled = bundle.digimons.values.where((d) => d.nameZh != null).length;
    stdout.writeln('[ilaopo] entries=${entries.length} '
        '比對成功=$matched（其中靠 dex fallback=$viaDex）'
        ' 對照不到=${unmatched.length}');
    stdout.writeln('[ilaopo] digimons 目前有 nameZh 的=$filled / '
        '${bundle.digimons.length}');
    if (unmatched.isNotEmpty) {
      stdout.writeln('[ilaopo] 對照不到的 ilaopo entry（可能是本作未收錄）：'
          '${unmatched.take(20).join('、')}'
          '${unmatched.length > 20 ? ' …' : ''}');
    }
  }
}
