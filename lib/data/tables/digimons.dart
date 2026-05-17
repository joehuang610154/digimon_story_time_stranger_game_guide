import 'package:drift/drift.dart';

import 'lookups.dart';
import 'personalities.dart';

/// 數碼寶貝主資料。lookup 欄位均為 FK；中日對照透過各 lookup 表 join 取得。
@DataClassName('DigimonRow')
class Digimons extends Table {
  /// 內部 slug（英文，做為穩定識別碼，例如 'agumon'）。
  TextColumn get id => text()();

  /// 圖鑑編號（遊戲內 No.）。
  IntColumn get dexNumber => integer().nullable()();

  /// 名稱（日 / 中 / 英）。
  TextColumn get nameJa => text()();
  TextColumn get nameZh => text().nullable()();
  TextColumn get nameEn => text().nullable()();

  /// 世代（FK -> stages）。
  TextColumn get stageId => text().nullable().references(Stages, #id)();

  /// 種族屬性（FK -> attributes，例 'no_data' / 'data' / 'vaccine' / 'virus' / 'free'）。
  TextColumn get attributeId => text().nullable().references(Attributes, #id)();

  /// 種族類型（FK -> types）。
  TextColumn get typeId => text().nullable().references(Types, #id)();

  /// 属性（FK -> elements）。
  TextColumn get elementId => text().nullable().references(Elements, #id)();

  /// 基本性格（FK -> personalities）。
  TextColumn get personalityId =>
      text().nullable().references(Personalities, #id)();

  /// 是否可作為デジライド（搭乘）對象。
  BoolColumn get canDigiride => boolean().nullable()();

  /// DLC 來源（NULL = 本體；例：'Alternate Dimension'）。
  TextColumn get dlcPack => text().nullable()();

  /// Lv99 + エージェントスキル全 MAX 狀態下的能力值。
  IntColumn get maxHp => integer().nullable()();
  IntColumn get maxSp => integer().nullable()();
  IntColumn get maxAtk => integer().nullable()();
  IntColumn get maxDef => integer().nullable()();
  IntColumn get maxInt => integer().nullable()();
  IntColumn get maxMen => integer().nullable()();
  IntColumn get maxSpd => integer().nullable()();

  /// 圖片路徑（user data 相對路徑，例：images/digimon/agumon.png）。
  TextColumn get imagePath => text().nullable()();

  /// 來源 URL（用於除錯/再爬取）。
  TextColumn get sourceUrlJa => text().nullable()();
  TextColumn get sourceUrlZh => text().nullable()();

  /// 自由文本備註（簡介、技能特性等）。
  TextColumn get descriptionJa => text().nullable()();
  TextColumn get descriptionZh => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
