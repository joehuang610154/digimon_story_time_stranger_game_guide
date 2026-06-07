import 'package:drift/drift.dart';

import 'app_database.dart';

/// 一次性載入的 lookup 表，供 UI join 顯示名稱。
class LookupCache {
  LookupCache({
    required this.stages,
    required this.attributes,
    required this.types,
    required this.elements,
    required this.personalities,
    required this.skillCategories,
    required this.stats,
  });

  final Map<String, StageRow> stages;
  final Map<String, AttributeRow> attributes;
  final Map<String, TypeRow> types;
  final Map<String, ElementRow> elements;
  final Map<String, PersonalityRow> personalities;
  final Map<String, SkillCategoryRow> skillCategories;
  final Map<String, StatRow> stats;
}

/// 一隻數碼寶貝的進化路線圖資料：root 自己 + 所有上游祖先 + 所有下游後代，
/// 以及這些節點之間的進化邊。
class EvolutionClosure {
  EvolutionClosure({
    required this.rootId,
    required this.nodes,
    required this.edges,
  });

  final String rootId;
  final List<DigimonRow> nodes;
  final List<EvolutionRow> edges;
}

/// 統一查詢介面。所有頁面只透過此類存取資料庫。
class DigimonRepository {
  DigimonRepository(this._db);

  final AppDatabase _db;

  // ---- Digimon ----

  /// 取得圖鑑全部。
  Future<List<DigimonRow>> allDigimons({String? keyword}) {
    final q = _db.select(_db.digimons);
    if (keyword != null && keyword.trim().isNotEmpty) {
      final k = '%${keyword.trim()}%';
      q.where(
        (t) => t.nameJa.like(k) | t.nameZh.like(k) | t.nameEn.like(k),
      );
    }
    q.orderBy([
      (t) => OrderingTerm(expression: t.dexNumber),
      (t) => OrderingTerm(expression: t.nameJa),
    ]);
    return q.get();
  }

  Future<DigimonRow?> digimonById(String id) {
    return (_db.select(_db.digimons)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  // ---- Evolutions ----

  /// 取得某數碼寶貝的進化去向（進化先）。只取 direction='evolve'，
  /// 否則退化（devolve）邊會被當成進化目標一起列出。
  Future<List<EvolutionRow>> evolutionsFrom(String digimonId) {
    return (_db.select(_db.evolutions)
          ..where((t) =>
              t.fromId.equals(digimonId) & t.direction.equals('evolve')))
        .get();
  }

  /// 取得某數碼寶貝的進化來源（進化元）。同樣只取 direction='evolve'。
  Future<List<EvolutionRow>> evolutionsTo(String digimonId) {
    return (_db.select(_db.evolutions)
          ..where((t) =>
              t.toId.equals(digimonId) & t.direction.equals('evolve')))
        .get();
  }

  Future<List<EvolutionRow>> allEvolutions() {
    return _db.select(_db.evolutions).get();
  }

  Future<List<EvolutionConditionRow>> conditionsFor(int evolutionId) {
    return (_db.select(_db.evolutionConditions)
          ..where((t) => t.evolutionId.equals(evolutionId)))
        .get();
  }

  /// 以 [rootId] 為中心，BFS 取得所有可達的祖先與後代節點，以及它們之間
  /// 的進化邊（只取 direction='evolve'）。
  ///
  /// 給 EvolutionRoutePage 用：兩個核心問題是「我能進化成什麼」與「什麼
  /// 可以進化成我」，所以只要找 root 的 forward closure ∪ backward closure。
  Future<EvolutionClosure> evolutionClosureOf(String rootId) async {
    final allEvos = (await allEvolutions())
        .where((e) => e.direction == 'evolve')
        .toList();
    final allDigis = await allDigimons();
    final byId = {for (final d in allDigis) d.id: d};

    final fwd = <String, List<EvolutionRow>>{};
    final bwd = <String, List<EvolutionRow>>{};
    for (final e in allEvos) {
      fwd.putIfAbsent(e.fromId, () => []).add(e);
      bwd.putIfAbsent(e.toId, () => []).add(e);
    }

    final reachable = <String>{rootId};
    final queue = <String>[rootId];
    while (queue.isNotEmpty) {
      final cur = queue.removeAt(0);
      for (final e in fwd[cur] ?? const <EvolutionRow>[]) {
        if (reachable.add(e.toId)) queue.add(e.toId);
      }
    }
    queue.add(rootId);
    while (queue.isNotEmpty) {
      final cur = queue.removeAt(0);
      for (final e in bwd[cur] ?? const <EvolutionRow>[]) {
        if (reachable.add(e.fromId)) queue.add(e.fromId);
      }
    }

    final nodes =
        reachable.map((id) => byId[id]).whereType<DigimonRow>().toList();
    final edges = allEvos
        .where((e) =>
            reachable.contains(e.fromId) && reachable.contains(e.toId))
        .toList();
    return EvolutionClosure(rootId: rootId, nodes: nodes, edges: edges);
  }

  // ---- Skills ----

  Future<List<SkillRow>> allSkills({String? keyword}) {
    final q = _db.select(_db.skills);
    if (keyword != null && keyword.trim().isNotEmpty) {
      final k = '%${keyword.trim()}%';
      q.where((t) => t.nameJa.like(k) | t.nameZh.like(k));
    }
    q.orderBy([(t) => OrderingTerm(expression: t.nameJa)]);
    return q.get();
  }

  Future<List<DigimonSkillRow>> skillsForDigimon(String digimonId) {
    return (_db.select(_db.digimonSkills)
          ..where((t) => t.digimonId.equals(digimonId)))
        .get();
  }

  // ---- Lookups ----

  Future<List<StageRow>> allStages() {
    final q = _db.select(_db.stages)
      ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]);
    return q.get();
  }

  Future<List<AttributeRow>> allAttributes() => _db.select(_db.attributes).get();

  Future<List<TypeRow>> allTypes() => _db.select(_db.types).get();

  Future<List<ElementRow>> allElements() => _db.select(_db.elements).get();

  Future<List<SkillCategoryRow>> allSkillCategories() =>
      _db.select(_db.skillCategories).get();

  Future<LookupCache> loadLookups() async {
    final stages = await allStages();
    final attrs = await allAttributes();
    final types = await allTypes();
    final elements = await allElements();
    final personalities = await allPersonalities();
    final skillCats = await allSkillCategories();
    final stats = await allStats();
    return LookupCache(
      stages: {for (final r in stages) r.id: r},
      attributes: {for (final r in attrs) r.id: r},
      types: {for (final r in types) r.id: r},
      elements: {for (final r in elements) r.id: r},
      personalities: {for (final r in personalities) r.id: r},
      skillCategories: {for (final r in skillCats) r.id: r},
      stats: {for (final r in stats) r.id: r},
    );
  }

  // ---- Personalities / Stats / Glossary ----

  Future<List<PersonalityRow>> allPersonalities() =>
      _db.select(_db.personalities).get();

  Future<List<StatRow>> allStats() => _db.select(_db.stats).get();

  Future<List<GlossaryRow>> allGlossary({String? category}) {
    final q = _db.select(_db.glossary);
    if (category != null && category.isNotEmpty) {
      q.where((t) => t.category.equals(category));
    }
    return q.get();
  }
}
