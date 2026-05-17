// 建立空白 schema 的 SQLite 檔。
//
// schema 來自 `lib/data/app_database.dart` 的 drift 定義（單一來源），
// 不再手寫 CREATE TABLE。改 schema 只要改 drift table → 跑 build_runner，
// 重新執行此腳本即可同步。
//
// 用法：
//   dart run tool/scrapers/init_db.dart
//   dart run tool/scrapers/init_db.dart --db=path/to.sqlite
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:digimon_story_time_stranger/data/app_database.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> argv) async {
  final parser = ArgParser()
    ..addOption('db',
        defaultsTo: p.join('assets', 'db', 'digimon.sqlite'),
        help: 'SQLite 輸出路徑。')
    ..addFlag('help', abbr: 'h', negatable: false);
  final args = parser.parse(argv);
  if (args['help'] as bool) {
    stdout.writeln(parser.usage);
    return;
  }
  await initDatabase(args['db'] as String);
}

/// 刪掉舊檔並以 drift schema 重新建立空 DB。
Future<void> initDatabase(String outPath) async {
  final outFile = File(outPath);
  if (outFile.existsSync()) outFile.deleteSync();
  outFile.parent.createSync(recursive: true);

  final db = AppDatabase.forFile(outFile);
  try {
    // 觸發 drift MigrationStrategy.onCreate -> Migrator.createAll()。
    await db.customStatement('PRAGMA foreign_keys = ON');
    await db.customSelect('SELECT 1').get();
  } finally {
    await db.close();
  }

  stdout.writeln('Created empty database at $outPath');
}
