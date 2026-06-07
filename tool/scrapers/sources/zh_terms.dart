/// 人工整理的 lookup / 性格 繁體中文對照。
///
/// 這些不是爬來的，而是 Digimon 系列的通用譯名（世代 / 種族 / 類型 / 屬性 / 元素 /
/// 技能分類 / 性格）。lookup 表的 id 就是日文原字串，是固定不變的小集合，所以可以
/// 安全地以 id 對應中文。
///
/// 寫法上只「補」既有 bundle record 的 `nameZh`（game8 先跑、已建好 record，
/// name_ja / sort_order 都保留），對應不到的 id 會印出來提醒。必須與 game8 同一次
/// sync 執行。
library;

import 'dart:io';

import '../models.dart';

class ZhTermsSource {
  Future<void> collect(ScrapedBundle bundle) async {
    final miss = <String>[];
    _apply(bundle.stages, _stages, 'stages', miss);
    _apply(bundle.attributes, _attributes, 'attributes', miss);
    _apply(bundle.types, _types, 'types', miss);
    _apply(bundle.elements, _elements, 'elements', miss);
    _apply(bundle.skillCategories, _skillCategories, 'skillCategories', miss);
    _applyPersonalities(bundle.personalities, _personalities, miss);

    if (miss.isNotEmpty) {
      stdout.writeln('[zh_terms] ⚠ 以下 id 在 bundle 找不到對應 record（game8 未跑或'
          ' id 有變），略過：${miss.join('、')}');
    }
  }

  void _apply(
    Map<String, LookupRecord> target,
    Map<String, String> zh,
    String label,
    List<String> miss,
  ) {
    var n = 0;
    var unknown = 0;
    for (final entry in zh.entries) {
      final rec = target[entry.key];
      if (rec == null) {
        miss.add('$label:${entry.key}');
        continue;
      }
      rec.nameZh = entry.value;
      n++;
    }
    for (final id in target.keys) {
      if (!zh.containsKey(id)) unknown++;
    }
    stdout.writeln('[zh_terms] $label 補中文 $n / ${target.length}'
        '${unknown > 0 ? '（$unknown 個無對照）' : ''}');
  }

  void _applyPersonalities(
    Map<String, PersonalityRecord> target,
    Map<String, String> zh,
    List<String> miss,
  ) {
    var n = 0;
    for (final entry in zh.entries) {
      final rec = target[entry.key];
      if (rec == null) {
        miss.add('personalities:${entry.key}');
        continue;
      }
      rec.nameZh = entry.value;
      n++;
    }
    stdout.writeln('[zh_terms] personalities 補中文 $n / ${target.length}');
  }

  static const _stages = <String, String>{
    '幼年期1': '幼年期I',
    '幼年期2': '幼年期II',
    '成長期': '成長期',
    '成熟期': '成熟期',
    'アーマー体': '裝甲體',
    'ハイブリッド体': '混合體',
    'ハイブリット体': '混合體',
    '完全体': '完全體',
    'ヴァリアブル': '可變種',
    '究極体': '究極體',
    '超究極体': '超究極體',
  };

  static const _attributes = <String, String>{
    'NODATA': '無資料',
    'ワクチン': '疫苗',
    'データ': '數據',
    'ウィルス': '病毒',
    'フリー': '自由',
    'アンノウン': '不明',
    'ヴァリアブル': '可變種',
    'ハイブリッド体': '混合體',
  };

  static const _elements = <String, String>{
    '鋼': '鋼',
    '氷': '冰',
    'バフ': '增益',
    '光': '光',
    '電気': '電',
    '火': '火',
    '闇': '暗',
    'デバフ': '減益',
    '無': '無',
    '水': '水',
    '草木': '草木',
    '地面': '地面',
    '風': '風',
    '回復': '回復',
    '物理': '物理',
  };

  static const _skillCategories = <String, String>{
    'special': '特殊技能',
    'attachment': '附件技能',
  };

  static const _personalities = <String, String>{
    '悪知恵': '詭詐',
    '気さく': '隨和',
    '蛮勇': '蠻勇',
    '包容力': '包容',
    '豪胆': '豪膽',
    '天啓': '天啟',
    '社交的': '社交',
    '献身的': '獻身',
    '戦略家': '戰略家',
    '熱血': '熱血',
    '日和見': '觀望',
    '過保護': '過度保護',
    '社交': '社交',
    '戦略化': '戰略',
    '勇敢': '勇敢',
    '人情家': '人情味',
    '豪胆である': '豪膽',
    '気さくである': '隨和',
  };

  static const _types = <String, String>{
    '種族不明': '種族不明',
    'マシーン型': '機械型',
    'スライム型': '史萊姆型',
    'レッサー型': '弱小型',
    '球根型': '球根型',
    '爬虫類型': '爬蟲類型',
    '聖獣型': '聖獸型',
    '海獣型': '海獸型',
    '獣型': '獸型',
    '武器型': '武器型',
    '昆虫型': '昆蟲型',
    'パペット型': '人偶型',
    'ヒナ鳥型': '雛鳥型',
    '鳥型': '鳥型',
    '哺乳類型': '哺乳類型',
    '小竜型': '小龍型',
    '天使型': '天使型',
    '甲殻類型': '甲殼類型',
    'サイボーグ型': '改造型',
    '鉱石型': '礦石型',
    '竜型': '龍型',
    '植物型': '植物型',
    '獣人型': '獸人型',
    '小悪魔型': '小惡魔型',
    '両生類型': '兩棲類型',
    '水棲哺乳類型': '水棲哺乳類型',
    '鬼人型': '鬼人型',
    'アンデッド型': '不死型',
    '幼虫型': '幼蟲型',
    '神人型': '神人型',
    '幻獣型': '幻獸型',
    '獣竜型': '獸龍型',
    '恐竜型': '恐龍型',
    '竜人型': '龍人型',
    '魔人型': '魔人型',
    '魔獣型': '魔獸型',
    '巨鳥型': '巨鳥型',
    '幻竜型': '幻龍型',
    '鳥人型': '鳥人型',
    '珍獣型': '珍獸型',
    '氷雪型': '冰雪型',
    '突然変異型': '突變型',
    '古代鳥型': '古代鳥型',
    '妖獣型': '妖獸型',
    '水棲型': '水棲型',
    '古代魚型': '古代魚型',
    '軟体型': '軟體型',
    '火炎型': '火焰型',
    '鎧竜型': '鎧龍型',
    '堕天使型': '墮天使型',
    '魔竜型': '魔龍型',
    '鉱物型': '礦物型',
    'ミュータント型': '變異型',
    '合成型': '合成型',
    'インベイド型': '入侵型',
    'ゴースト型': '幽靈型',
    '食虫植物型': '食蟲植物型',
    '戦士型': '戰士型',
    '妖精型': '妖精型',
    '天竜型': '天龍型',
    '聖竜型': '聖龍型',
    '大天使型': '大天使型',
    '古代獣型': '古代獸型',
    '妖鳥型': '妖鳥型',
    '古代甲殻類': '古代甲殼類',
    'パーフェクト型': '完美型',
    '角竜型': '角龍型',
    '水棲獣人型': '水棲獸人型',
    '首長竜型': '蛇頸龍型',
    '地竜型': '地龍型',
    '宇宙人型': '宇宙人型',
    '魔法戦士型': '魔法戰士型',
    '魔王型': '魔王型',
    '聖騎士型': '聖騎士型',
    '聖鳥型': '聖鳥型',
    '座天使型': '座天使型',
    '力天使型': '力天使型',
    '智天使型': '智天使型',
    '光竜型': '光龍型',
    '能天使型': '能天使型',
    '熾天使型': '熾天使型',
    '聖剣型': '聖劍型',
    '獣騎士型': '獸騎士型',
    '古代突然変異型': '古代突變型',
    '暗黒騎士型': '暗黑騎士型',
    '機竜型': '機龍型',
    '邪竜型': '邪龍型',
    '古代竜型': '古代龍型',
    '古代竜人': '古代龍人',
    '竜騎士型': '龍騎士型',
    'NODATE': '無資料',
    '古代聖騎士型': '古代聖騎士型',
    '特異型': '特異型',
    '銀河型': '銀河型',
    '魔神型': '魔神型',
    '不明': '不明',
  };
}
