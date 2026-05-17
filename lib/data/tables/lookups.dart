import 'package:drift/drift.dart';

/// 進化階段（幼年期1 / 幼年期2 / 成長期 / 成熟期 / 完全体 / 究極体 / 究極体超 等）。
@DataClassName('StageRow')
class Stages extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 種族屬性（ワクチン種 / データ種 / ウィルス種 / フリー / NO DATA 等）。
@DataClassName('AttributeRow')
class Attributes extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 種族類型（タイプ：龍型 / 海獣型 / 種族不明 等）。
@DataClassName('TypeRow')
class Types extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 属性（火 / 水 / 草木 / 氷 / 電気 / 鋼 / 風 / 地面 / 光 / 闇 / 無 等）。
@DataClassName('ElementRow')
class Elements extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 技能分類（スペシャル / アタッチメント / 通常 等）。
@DataClassName('SkillCategoryRow')
class SkillCategories extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
