// 檢查 SQLite 內容的小工具：列 schema、計算 row 數、抽樣 row，或跑 ad-hoc SQL。
// 給 dev 在 init_db / sync 後快速驗證用。
//
// 用法：
//   dart run tool/scrapers/inspect_db.dart                   # 預設讀 assets/db/digimon.sqlite
//   dart run tool/scrapers/inspect_db.dart --db=path/to.sqlite
//   dart run tool/scrapers/inspect_db.dart --table=digimons  # 只看單一表
//   dart run tool/scrapers/inspect_db.dart --sample=5        # 每張表抽 N 列
//   dart run tool/scrapers/inspect_db.dart --schema          # 只印 schema
//   dart run tool/scrapers/inspect_db.dart --sql="SELECT ..." # 跑 ad-hoc query
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

Future<void> main(List<String> argv) async {
  final parser = ArgParser()
    ..addOption('db',
        defaultsTo: p.join('assets', 'db', 'digimon.sqlite'),
        help: 'SQLite 路徑。')
    ..addOption('table', help: '只看指定表（逗號分隔可多張）。')
    ..addOption('sample',
        defaultsTo: '0', help: '每張表抽 N 列輸出（0 不抽樣）。')
    ..addFlag('schema',
        defaultsTo: false, help: '只印每張表的欄位與 FK，不算 count。')
    ..addOption('sql',
        help: '跑 ad-hoc SQL（read-only）；指定時其他選項忽略。')
    ..addOption('sql-limit',
        defaultsTo: '50', help: '--sql 時每列最大字數截斷（防止輸出爆掉）。')
    ..addFlag('help', abbr: 'h', negatable: false);

  final args = parser.parse(argv);
  if (args['help'] as bool) {
    stdout.writeln(parser.usage);
    return;
  }

  final dbPath = args['db'] as String;
  if (!File(dbPath).existsSync()) {
    stderr.writeln('找不到 DB: $dbPath');
    exitCode = 2;
    return;
  }

  final db = sqlite3.open(dbPath, mode: OpenMode.readOnly);
  try {
    final sql = args['sql'] as String?;
    if (sql != null && sql.trim().isNotEmpty) {
      final cellLimit = int.parse(args['sql-limit'] as String);
      _runSql(db, sql.trim(), cellLimit: cellLimit);
      return;
    }

    final wanted = (args['table'] as String?)
        ?.split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toSet();
    final tables = db
        .select(
            "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name")
        .map((r) => r['name'] as String)
        .where((n) => wanted == null || wanted.contains(n))
        .toList();

    final sample = int.parse(args['sample'] as String);
    final schemaOnly = args['schema'] as bool;

    stdout.writeln('DB: ${p.normalize(dbPath)}');
    stdout.writeln('Tables: ${tables.length}');
    stdout.writeln('');

    for (final t in tables) {
      _dumpTable(db, t, schemaOnly: schemaOnly, sample: sample);
      stdout.writeln('');
    }
  } finally {
    db.dispose();
  }
}

void _dumpTable(
  Database db,
  String table, {
  required bool schemaOnly,
  required int sample,
}) {
  final cols = db.select('PRAGMA table_info($table)');
  final fks = db.select('PRAGMA foreign_key_list($table)');
  final count = schemaOnly
      ? null
      : (db.select('SELECT COUNT(*) AS c FROM $table').first['c'] as int);

  final header =
      schemaOnly ? '## $table' : '## $table  (rows=$count)';
  stdout.writeln(header);
  for (final c in cols) {
    final pk = (c['pk'] as int) > 0 ? ' PK' : '';
    final notnull = (c['notnull'] as int) == 1 ? ' NOT NULL' : '';
    stdout.writeln('  - ${c['name']}: ${c['type']}$notnull$pk');
  }
  for (final fk in fks) {
    stdout.writeln(
        '  FK: ${fk['from']} -> ${fk['table']}(${fk['to']})');
  }

  if (sample > 0 && (count ?? 0) > 0) {
    final rows = db.select('SELECT * FROM $table LIMIT $sample');
    stdout.writeln('  sample:');
    for (final r in rows) {
      final pairs = <String>[];
      for (final k in r.keys) {
        final v = r[k];
        if (v == null) continue;
        final s = v.toString();
        pairs.add('$k=${s.length > 60 ? '${s.substring(0, 60)}…' : s}');
      }
      stdout.writeln('    { ${pairs.join(', ')} }');
    }
  }
}

void _runSql(Database db, String sql, {required int cellLimit}) {
  final rows = db.select(sql);
  stdout.writeln('SQL: $sql');
  stdout.writeln('rows: ${rows.length}');
  stdout.writeln('');
  if (rows.isEmpty) return;
  final cols = rows.first.keys.toList();
  String trunc(Object? v) {
    if (v == null) return '';
    final s = v.toString().replaceAll(RegExp(r'[\r\n]+'), ' / ');
    return s.length > cellLimit ? '${s.substring(0, cellLimit)}…' : s;
  }
  final widths = <int>[
    for (final c in cols)
      cols.indexOf(c) == -1
          ? 0
          : [c.length, ...rows.map((r) => trunc(r[c]).length)]
              .reduce((a, b) => a > b ? a : b),
  ];
  String pad(String s, int w) => s + ' ' * (w - s.length).clamp(0, w);
  stdout.writeln(
      [for (var i = 0; i < cols.length; i++) pad(cols[i], widths[i])]
          .join(' | '));
  stdout.writeln(
      [for (var i = 0; i < cols.length; i++) '-' * widths[i]].join('-+-'));
  for (final r in rows) {
    stdout.writeln([
      for (var i = 0; i < cols.length; i++) pad(trunc(r[cols[i]]), widths[i])
    ].join(' | '));
  }
}
