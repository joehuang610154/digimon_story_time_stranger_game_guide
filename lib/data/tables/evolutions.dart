import 'package:drift/drift.dart';

import 'digimons.dart';
import 'personalities.dart';

/// 進化連結：A 進化 -> B。一條紀錄代表一條有向邊。
@DataClassName('EvolutionRow')
class Evolutions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 來源數碼寶貝 slug。
  TextColumn get fromId => text().references(Digimons, #id)();

  /// 目標數碼寶貝 slug。
  TextColumn get toId => text().references(Digimons, #id)();

  /// 進化方向：'evolve' 進化 / 'devolve' 退化。
  TextColumn get direction => text().withDefault(const Constant('evolve'))();

  /// 條件原文（多行 `<br>` 串接後保留為單一字串，供 UI 直接顯示）。
  TextColumn get conditionTextJa => text().nullable()();
  TextColumn get conditionTextZh => text().nullable()();
}

/// 從 evolution 條件原文解析出的結構化條件項目。一條 evolution 可有多筆。
@DataClassName('EvolutionConditionRow')
class EvolutionConditions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get evolutionId => integer().references(Evolutions, #id)();

  /// 條件種類：
  /// - 'agent_rank'   ：エージェントランク N 以上 → threshold=N
  /// - 'stat_min'     ：某 stat 上限值 N 以上 → statId='hp'/'sp'/... + threshold=N
  /// - 'level'        ：等級 N 以上 → threshold=N
  /// - 'battles'      ：戰鬥次數 N → threshold=N
  /// - 'abi'          ：ABI N 以上 → threshold=N
  /// - 'personality'  ：「X 的性格須為 P」→ digimonId=X + personalityId=P
  ///                    （X = from_id 為自己；X ≠ from_id 為合體 partner）
  /// - 'item'         ：必要道具 → text_ja/zh
  /// - 'special'      ：其他 fallback → text_ja/zh
  TextColumn get kind => text()();

  /// kind='stat_min' 時的 stat（FK stats.id）。
  TextColumn get statId => text().nullable()();

  /// 數值門檻（agent_rank / stat_min / level / battles / abi 用）。
  IntColumn get threshold => integer().nullable()();

  /// 條件適用的 Digimon（kind='personality' 用；自己或合體 partner）。
  TextColumn get digimonId =>
      text().nullable().references(Digimons, #id)();

  /// kind='personality' 用。
  TextColumn get personalityId =>
      text().nullable().references(Personalities, #id)();

  /// 非數值類型的條件原文（kind='item' / 'special' 等用）。
  TextColumn get textJa => text().nullable()();
  TextColumn get textZh => text().nullable()();
}
