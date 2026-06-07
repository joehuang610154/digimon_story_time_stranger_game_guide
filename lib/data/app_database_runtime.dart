import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_database.dart';

const _bundledDbAssetPath = 'assets/db/digimon.sqlite';
const _dbFileName = 'digimon.sqlite';

/// bundle DB schema 版本標記。schema 改動時 bump，app 啟動會用此值
/// 與 user data 目錄裡的 `db_version.txt` 比對，不同就重新從 bundle 複製過去。
///
/// 由 `tool/scrapers/sync.dart --bump-version` 自動改寫此行；手動改也可，
/// 但**必須**維持 `const bundledDbVersion = '...';` 這個 pattern，
/// 否則自動 bump 的 regex 會找不到。
const bundledDbVersion = '2026-06-07-add-zh-names';

/// App 啟動時呼叫，回傳已綁定 user data 目錄與 assets bundle 的 [AppDatabase]。
AppDatabase openAppDatabase() {
  return AppDatabase.forExecutor(_openConnection());
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await _resolveDatabaseFile();
    return NativeDatabase(file, logStatements: false);
  });
}

/// 解析資料庫位置：
/// - 將檔案放在 user data 目錄
/// - 若不存在則從 assets bundle 複製
/// - bundle 版本（[bundledDbVersion]）若與 user data 中的版本標記不同，重新複製
Future<File> _resolveDatabaseFile() async {
  final dir = await getApplicationSupportDirectory();
  final dbDir = Directory(p.join(dir.path, 'db'));
  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
  }
  final dbFile = File(p.join(dbDir.path, _dbFileName));
  final versionFile = File(p.join(dbDir.path, 'db_version.txt'));

  final exists = await dbFile.exists();
  final currentVersion = await versionFile.exists()
      ? (await versionFile.readAsString()).trim()
      : null;

  if (!exists || currentVersion != bundledDbVersion) {
    await _copyBundledDatabase(dbFile);
    await versionFile.writeAsString(bundledDbVersion, flush: true);
  }
  return dbFile;
}

Future<void> _copyBundledDatabase(File target) async {
  try {
    final data = await rootBundle.load(_bundledDbAssetPath);
    await target.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
  } catch (_) {
    // assets bundle 中尚未放置 SQLite 檔時，建立空檔讓 Drift 自行 createAll。
    if (!await target.exists()) {
      await target.create(recursive: true);
    }
  }
}
