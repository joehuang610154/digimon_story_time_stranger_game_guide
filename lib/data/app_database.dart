import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'tables/digimons.dart';
import 'tables/evolutions.dart';
import 'tables/lookups.dart';
import 'tables/personalities.dart';
import 'tables/skills.dart';

part 'app_database.g.dart';

/// 純 drift schema 定義。**不要**在此檔 import Flutter / path_provider，
/// 以便 `tool/scrapers/init_db.dart` 也能 `dart run` 直接 reuse 同一 schema。
/// 執行期初始化（assets bundle 複製、user data 路徑、版本檢查）放在
/// `app_database_runtime.dart`。
@DriftDatabase(tables: [
  Digimons,
  Evolutions,
  EvolutionConditions,
  Skills,
  DigimonSkills,
  Stages,
  Attributes,
  Types,
  Elements,
  SkillCategories,
  Personalities,
  Stats,
  Glossary,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase.forExecutor(super.e);

  /// 直接針對檔案開啟（init_db / 測試 / scraper 共用入口）。
  AppDatabase.forFile(File file) : this.forExecutor(NativeDatabase(file));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}
