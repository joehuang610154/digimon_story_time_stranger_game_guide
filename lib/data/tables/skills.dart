import 'package:drift/drift.dart';

import 'digimons.dart';
import 'lookups.dart';

/// 技能/スキル 主資料。
@DataClassName('SkillRow')
class Skills extends Table {
  /// 內部 slug。
  TextColumn get id => text()();

  /// 技能名稱（日 / 中 / 英）。
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();
  TextColumn get nameEn => text().nullable()();

  /// 屬性（FK -> elements）。
  TextColumn get elementId => text().nullable().references(Elements, #id)();

  /// 類型（FK -> skill_categories：special / attachment / normal 等）。
  TextColumn get categoryId =>
      text().nullable().references(SkillCategories, #id)();

  /// 威力。
  IntColumn get power => integer().nullable()();

  /// 命中。
  IntColumn get accuracy => integer().nullable()();

  /// SP 消耗。
  IntColumn get spCost => integer().nullable()();

  /// 目標（單體、全體、自己 等）。
  TextColumn get targetJa => text().nullable()();
  TextColumn get targetZh => text().nullable()();

  /// 效果描述（日 / 中）。
  TextColumn get descriptionJa => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 數碼寶貝與技能的關聯，包含習得條件。
@DataClassName('DigimonSkillRow')
class DigimonSkills extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get digimonId => text().references(Digimons, #id)();
  TextColumn get skillId => text().references(Skills, #id)();

  /// 習得方式：'level' / 'inherit' / 'event' / 'item' 等。
  TextColumn get acquisition => text().withDefault(const Constant('level'))();

  /// 習得等級（若 acquisition = 'level'）。
  IntColumn get learnLevel => integer().nullable()();

  /// 備註（日 / 中）。
  TextColumn get noteJa => text().nullable()();
  TextColumn get noteZh => text().nullable()();
}
