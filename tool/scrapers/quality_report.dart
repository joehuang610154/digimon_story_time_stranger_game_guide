/// Sync 收尾品質報告：用一份固定 SQL 巡邏 DB，把易回歸/容易看漏的指標印出來。
///
/// 從 sync.dart 末端自動呼叫；也可單獨：
/// ```
/// dart run tool/scrapers/quality_report.dart
/// dart run tool/scrapers/quality_report.dart --db=path/to.sqlite
/// ```
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

const _expectedDigimonCount = 465;

Future<void> main(List<String> argv) async {
  final parser = ArgParser()
    ..addOption('db', defaultsTo: p.join('assets', 'db', 'digimon.sqlite'))
    ..addFlag('help', abbr: 'h', negatable: false);
  final args = parser.parse(argv);
  if (args['help'] as bool) {
    stdout.writeln(parser.usage);
    return;
  }
  runQualityReport(args['db'] as String);
}

/// 印出固定區塊的品質報告。讀-only 操作；不會修改 DB。
void runQualityReport(String dbPath) {
  if (!File(dbPath).existsSync()) {
    stderr.writeln('[quality] 找不到 DB: $dbPath');
    return;
  }
  final db = sqlite3.open(dbPath, mode: OpenMode.readOnly);
  try {
    stdout.writeln('');
    stdout.writeln('================ Quality Report ================');
    stdout.writeln('DB: ${p.normalize(dbPath)}');

    _section(db);
    _digimonCoverage(db);
    _missingImages(db);
    _dlcGap(db);
    _lookupDistinct(db, 'stages');
    _lookupDistinct(db, 'attributes');
    _lookupDistinct(db, 'types');
    _lookupDistinct(db, 'elements');
    _evolutionConditionCoverage(db);
    _nameZhCoverage(db);
    _fkOrphans(db);
    stdout.writeln('================================================');
    stdout.writeln('');
  } finally {
    db.dispose();
  }
}

void _section(Database db) {
  final counts = <String, int>{};
  for (final t in const [
    'digimons',
    'evolutions',
    'evolution_conditions',
    'skills',
    'digimon_skills',
    'personalities',
    'stages',
    'attributes',
    'types',
    'elements',
    'skill_categories',
    'stats',
    'glossary',
  ]) {
    counts[t] = db.select('SELECT COUNT(*) AS c FROM $t').first['c'] as int;
  }
  stdout.writeln('');
  stdout.writeln('-- row counts --');
  counts.forEach((k, v) => stdout.writeln('  $k: $v'));
}

void _digimonCoverage(Database db) {
  final n = db.select('SELECT COUNT(*) AS c FROM digimons').first['c'] as int;
  final tag = n == _expectedDigimonCount
      ? 'OK'
      : 'WARN (expected $_expectedDigimonCount)';
  stdout.writeln('');
  stdout.writeln('-- digimons coverage --');
  stdout.writeln('  total = $n  [$tag]');

  final nullDex = db
      .select('SELECT COUNT(*) AS c FROM digimons WHERE dex_number IS NULL')
      .first['c'] as int;
  stdout.writeln('  dex_number NULL: $nullDex');

  final missingStats = db.select('''
    SELECT COUNT(*) AS c FROM digimons
    WHERE max_hp IS NULL OR max_sp IS NULL OR max_atk IS NULL
       OR max_def IS NULL OR max_int IS NULL OR max_men IS NULL OR max_spd IS NULL
  ''').first['c'] as int;
  stdout.writeln('  缺 Lv99 ステータス (任一欄 NULL): $missingStats');
}

void _missingImages(Database db) {
  final rows = db.select('''
    SELECT id, name_ja FROM digimons
    WHERE image_path IS NULL OR image_path = ''
    ORDER BY dex_number, id
  ''');
  stdout.writeln('');
  stdout.writeln('-- images --');
  stdout.writeln('  digimons 缺圖: ${rows.length}');
  for (final r in rows.take(10)) {
    stdout.writeln('    - ${r['id']}  ${r['name_ja']}');
  }
  if (rows.length > 10) {
    stdout.writeln('    ... (+${rows.length - 10} more)');
  }
}

void _dlcGap(Database db) {
  // game8 DLC 頁僅含第 1 弾 5 隻；dex 458–475 黑色版本族目前無 DLC 標記。
  final rows = db.select('''
    SELECT COUNT(*) AS c FROM digimons
    WHERE dex_number BETWEEN 458 AND 475 AND dlc_pack IS NULL
  ''').first['c'] as int;
  stdout.writeln('');
  stdout.writeln('-- DLC tagging --');
  stdout.writeln('  dex 458–475 dlc_pack NULL: $rows  '
      '(目前已知 gap：game8 DLC 頁未涵蓋黑色版本族)');
  final tagged = db.select('''
    SELECT dlc_pack, COUNT(*) AS c FROM digimons
    WHERE dlc_pack IS NOT NULL
    GROUP BY dlc_pack ORDER BY dlc_pack
  ''');
  for (final r in tagged) {
    stdout.writeln('  dlc_pack="${r['dlc_pack']}": ${r['c']}');
  }
}

void _lookupDistinct(Database db, String table) {
  // 列出實際被 digimons 引用的 lookup 值與計數，方便眼看是否混入異常 tag。
  final fkCol = {
    'stages': 'stage_id',
    'attributes': 'attribute_id',
    'types': 'type_id',
    'elements': 'element_id',
  }[table];
  if (fkCol == null) return;
  final rows = db.select('''
    SELECT t.id, t.name_ja, COUNT(d.id) AS used
    FROM $table t
    LEFT JOIN digimons d ON d.$fkCol = t.id
    GROUP BY t.id, t.name_ja
    ORDER BY used DESC, t.id
  ''');
  stdout.writeln('');
  stdout.writeln('-- $table (digimons 使用次數) --');
  for (final r in rows) {
    stdout.writeln(
        '  ${r['used'].toString().padLeft(4)}  ${r['id']}  (${r['name_ja']})');
  }
}

void _evolutionConditionCoverage(Database db) {
  final total = db
      .select('SELECT COUNT(*) AS c FROM evolution_conditions')
      .first['c'] as int;
  final byKind = db.select('''
    SELECT kind, COUNT(*) AS c FROM evolution_conditions
    GROUP BY kind ORDER BY c DESC
  ''');
  final special = byKind
      .where((r) => r['kind'] == 'special')
      .fold<int>(0, (s, r) => s + (r['c'] as int));
  final pct =
      total == 0 ? '0%' : '${(special * 100 / total).toStringAsFixed(1)}%';
  stdout.writeln('');
  stdout.writeln('-- evolution_conditions --');
  stdout.writeln('  total: $total   special (未結構化): $special  ($pct)');
  for (final r in byKind) {
    stdout.writeln(
        '    ${r['c'].toString().padLeft(5)}  ${r['kind']}');
  }
}

void _nameZhCoverage(Database db) {
  stdout.writeln('');
  stdout.writeln('-- name_zh coverage (中文補強進度) --');
  for (final t in const [
    'digimons',
    'skills',
    'stages',
    'attributes',
    'types',
    'elements',
    'personalities',
  ]) {
    final total = db.select('SELECT COUNT(*) AS c FROM $t').first['c'] as int;
    if (total == 0) {
      stdout.writeln('  $t: 0 rows');
      continue;
    }
    final filled = db
        .select(
            "SELECT COUNT(*) AS c FROM $t WHERE name_zh IS NOT NULL AND name_zh <> ''")
        .first['c'] as int;
    final pct = (filled * 100 / total).toStringAsFixed(1);
    stdout.writeln('  $t: $filled / $total  ($pct%)');
  }
}

void _fkOrphans(Database db) {
  // PRAGMA foreign_key_check 一次回傳所有違反 FK 的 row。
  final rows = db.select('PRAGMA foreign_key_check');
  stdout.writeln('');
  stdout.writeln('-- FK orphans --');
  if (rows.isEmpty) {
    stdout.writeln('  OK，無孤兒。');
    return;
  }
  stdout.writeln('  WARN: ${rows.length} orphan rows');
  for (final r in rows.take(20)) {
    stdout.writeln(
        '    table=${r['table']} rowid=${r['rowid']} '
        'parent=${r['parent']} fkid=${r['fkid']}');
  }
  if (rows.length > 20) {
    stdout.writeln('    ... (+${rows.length - 20} more)');
  }
}
