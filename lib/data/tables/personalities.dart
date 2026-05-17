import 'package:drift/drift.dart';

/// 個性（性格）一覽。影響成長傾向。
@DataClassName('PersonalityRow')
class Personalities extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();

  /// 對應上升的能力（例：「攻撃力上昇」）。
  TextColumn get upStatJa => text().nullable()();
  TextColumn get upStatZh => text().nullable()();

  /// 對應下降的能力。
  TextColumn get downStatJa => text().nullable()();
  TextColumn get downStatZh => text().nullable()();

  TextColumn get descriptionJa => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 才能值 / 養成參數說明（最大 HP、攻擊、防禦、知力、精神、素早さ 等）。
@DataClassName('StatRow')
class Stats extends Table {
  TextColumn get id => text()();
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();
  TextColumn get descriptionJa => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 一般的養成相關詞彙表（友情值、蓄積值、エージェントランク 等）。
@DataClassName('GlossaryRow')
class Glossary extends Table {
  TextColumn get id => text()();
  TextColumn get termJa => text()();
  TextColumn get termZh => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get descriptionJa => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
