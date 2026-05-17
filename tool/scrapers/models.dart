/// 爬蟲端共用的純 Dart 資料模型（避免依賴 Drift）。
library;

class DigimonRecord {
  DigimonRecord({
    required this.id,
    this.dexNumber,
    required this.nameJa,
    this.nameZh,
    this.nameEn,
    this.stageId,
    this.attributeId,
    this.typeId,
    this.elementId,
    this.personalityId,
    this.canDigiride,
    this.dlcPack,
    this.maxHp,
    this.maxSp,
    this.maxAtk,
    this.maxDef,
    this.maxInt,
    this.maxMen,
    this.maxSpd,
    this.imagePath,
    this.imageUrl,
    this.sourceUrlJa,
    this.sourceUrlZh,
    this.descriptionJa,
    this.descriptionZh,
  });

  final String id;
  int? dexNumber;
  final String nameJa;
  String? nameZh;
  String? nameEn;
  String? stageId;
  String? attributeId;
  String? typeId;
  String? elementId;
  String? personalityId;
  bool? canDigiride;
  String? dlcPack;
  int? maxHp;
  int? maxSp;
  int? maxAtk;
  int? maxDef;
  int? maxInt;
  int? maxMen;
  int? maxSpd;
  String? imagePath;
  String? imageUrl;
  String? sourceUrlJa;
  String? sourceUrlZh;
  String? descriptionJa;
  String? descriptionZh;
}

class EvolutionRecord {
  EvolutionRecord({
    required this.fromId,
    required this.toId,
    this.direction = 'evolve',
    this.conditionTextJa,
    this.conditionTextZh,
    this.conditions = const [],
  });

  final String fromId;
  final String toId;
  final String direction;
  String? conditionTextJa;
  String? conditionTextZh;
  List<EvolutionConditionRecord> conditions;
}

class EvolutionConditionRecord {
  EvolutionConditionRecord({
    required this.kind,
    this.statId,
    this.threshold,
    this.digimonId,
    this.personalityId,
    this.textJa,
    this.textZh,
  });

  /// 'agent_rank' | 'stat_min' | 'level' | 'battles' | 'abi' | 'personality' | 'item' | 'special'
  final String kind;
  String? statId;
  int? threshold;

  /// kind='personality' 時的條件對象。等於 evolution.from_id 表示自己；不等於表示合體 partner。
  String? digimonId;
  String? personalityId;
  String? textJa;
  String? textZh;
}

class SkillRecord {
  SkillRecord({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.nameEn,
    this.elementId,
    this.categoryId,
    this.power,
    this.accuracy,
    this.spCost,
    this.targetJa,
    this.targetZh,
    this.descriptionJa,
    this.descriptionZh,
  });

  final String id;
  final String nameJa;
  String? nameZh;
  String? nameEn;
  String? elementId;
  String? categoryId;
  int? power;
  int? accuracy;
  int? spCost;
  String? targetJa;
  String? targetZh;
  String? descriptionJa;
  String? descriptionZh;
}

class DigimonSkillLink {
  DigimonSkillLink({
    required this.digimonId,
    required this.skillId,
    this.acquisition = 'level',
    this.learnLevel,
    this.noteJa,
    this.noteZh,
  });

  final String digimonId;
  final String skillId;
  final String acquisition;
  int? learnLevel;
  String? noteJa;
  String? noteZh;
}

class PersonalityRecord {
  PersonalityRecord({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.upStatJa,
    this.upStatZh,
    this.downStatJa,
    this.downStatZh,
    this.descriptionJa,
    this.descriptionZh,
  });

  final String id;
  final String nameJa;
  String? nameZh;
  String? upStatJa;
  String? upStatZh;
  String? downStatJa;
  String? downStatZh;
  String? descriptionJa;
  String? descriptionZh;
}

class StatRecord {
  StatRecord({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.descriptionJa,
    this.descriptionZh,
  });
  final String id;
  final String nameJa;
  String? nameZh;
  String? descriptionJa;
  String? descriptionZh;
}

class GlossaryRecord {
  GlossaryRecord({
    required this.id,
    required this.termJa,
    this.termZh,
    this.category,
    this.descriptionJa,
    this.descriptionZh,
  });
  final String id;
  final String termJa;
  String? termZh;
  String? category;
  String? descriptionJa;
  String? descriptionZh;
}

/// 通用 lookup 表 record（stage / attribute / type / element / skill_category）。
class LookupRecord {
  LookupRecord({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.sortOrder,
  });
  final String id;
  final String nameJa;
  String? nameZh;
  int? sortOrder;
}

/// 一次爬蟲輸出的總集，由各 source 累積後寫回 SQLite。
class ScrapedBundle {
  final Map<String, DigimonRecord> digimons = {};
  final List<EvolutionRecord> evolutions = [];
  final Map<String, SkillRecord> skills = {};
  final List<DigimonSkillLink> digimonSkills = [];
  final Map<String, PersonalityRecord> personalities = {};
  final Map<String, StatRecord> stats = {};
  final Map<String, GlossaryRecord> glossary = {};

  // Lookup 表
  final Map<String, LookupRecord> stages = {};
  final Map<String, LookupRecord> attributes = {};
  final Map<String, LookupRecord> types = {};
  final Map<String, LookupRecord> elements = {};
  final Map<String, LookupRecord> skillCategories = {};
}
