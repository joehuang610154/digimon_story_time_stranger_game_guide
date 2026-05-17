/// 將 `ScrapedBundle` 寫入 SQLite 檔。
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import 'models.dart';

class SqliteWriter {
  SqliteWriter(this.dbPath);
  final String dbPath;

  void write(ScrapedBundle bundle) {
    final dbFile = File(dbPath);
    if (!dbFile.parent.existsSync()) {
      dbFile.parent.createSync(recursive: true);
    }
    if (!dbFile.existsSync()) {
      stderr.writeln(
          '⚠ $dbPath 不存在，請先執行 `dart run tool/scrapers/init_db.dart`');
      exitCode = 2;
      return;
    }

    final db = sqlite3.open(dbPath);
    db.execute('PRAGMA foreign_keys = ON');
    db.execute('BEGIN');
    try {
      // lookup 表先寫，digimons 才能 FK 對到。
      _writeLookup(db, 'stages', bundle.stages.values, includeSortOrder: true);
      _writeLookup(db, 'attributes', bundle.attributes.values);
      _writeLookup(db, 'types', bundle.types.values);
      _writeLookup(db, 'elements', bundle.elements.values);
      _writeLookup(db, 'skill_categories', bundle.skillCategories.values);

      _writePersonalities(db, bundle.personalities.values);
      _writeStats(db, bundle.stats.values);

      _writeDigimons(db, bundle.digimons.values);
      _writeEvolutions(db, bundle.evolutions);

      _writeSkills(db, bundle.skills.values);
      _writeDigimonSkills(db, bundle.digimonSkills);

      _writeGlossary(db, bundle.glossary.values);
      db.execute('COMMIT');
    } catch (e) {
      db.execute('ROLLBACK');
      rethrow;
    } finally {
      db.dispose();
    }

    stdout.writeln('Wrote ${bundle.digimons.length} digimons, '
        '${bundle.evolutions.length} evolutions, '
        '${bundle.skills.length} skills, '
        '${bundle.digimonSkills.length} digimon-skill links, '
        '${bundle.personalities.length} personalities, '
        '${bundle.stats.length} stats, '
        '${bundle.glossary.length} glossary entries, '
        'lookups: stages=${bundle.stages.length} '
        'attrs=${bundle.attributes.length} '
        'types=${bundle.types.length} '
        'elements=${bundle.elements.length} '
        'skillCats=${bundle.skillCategories.length} '
        '→ ${p.normalize(dbPath)}');
  }

  void _writeLookup(
    Database db,
    String table,
    Iterable<LookupRecord> records, {
    bool includeSortOrder = false,
  }) {
    final cols = includeSortOrder
        ? '(id, name_ja, name_zh, sort_order) VALUES (?, ?, ?, ?)'
        : '(id, name_ja, name_zh) VALUES (?, ?, ?)';
    final extraSet = includeSortOrder
        ? ', sort_order = COALESCE(excluded.sort_order, $table.sort_order)'
        : '';
    final stmt = db.prepare('''
      INSERT INTO $table $cols
      ON CONFLICT(id) DO UPDATE SET
        name_ja = excluded.name_ja,
        name_zh = COALESCE(excluded.name_zh, $table.name_zh)$extraSet
    ''');
    for (final r in records) {
      stmt.execute(includeSortOrder
          ? [r.id, r.nameJa, r.nameZh, r.sortOrder]
          : [r.id, r.nameJa, r.nameZh]);
    }
    stmt.dispose();
  }

  void _writeDigimons(Database db, Iterable<DigimonRecord> records) {
    final stmt = db.prepare(r'''
      INSERT INTO digimons (
        id, dex_number, name_ja, name_zh, name_en,
        stage_id, attribute_id, type_id, element_id, personality_id,
        can_digiride, dlc_pack,
        max_hp, max_sp, max_atk, max_def, max_int, max_men, max_spd,
        image_path, source_url_ja, source_url_zh,
        description_ja, description_zh
      ) VALUES (
        ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?,
        ?, ?,
        ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?,
        ?, ?
      )
      ON CONFLICT(id) DO UPDATE SET
        dex_number = COALESCE(excluded.dex_number, digimons.dex_number),
        name_ja = excluded.name_ja,
        name_zh = COALESCE(excluded.name_zh, digimons.name_zh),
        name_en = COALESCE(excluded.name_en, digimons.name_en),
        stage_id = COALESCE(excluded.stage_id, digimons.stage_id),
        attribute_id = COALESCE(excluded.attribute_id, digimons.attribute_id),
        type_id = COALESCE(excluded.type_id, digimons.type_id),
        element_id = COALESCE(excluded.element_id, digimons.element_id),
        personality_id = COALESCE(excluded.personality_id, digimons.personality_id),
        can_digiride = COALESCE(excluded.can_digiride, digimons.can_digiride),
        dlc_pack = COALESCE(excluded.dlc_pack, digimons.dlc_pack),
        max_hp = COALESCE(excluded.max_hp, digimons.max_hp),
        max_sp = COALESCE(excluded.max_sp, digimons.max_sp),
        max_atk = COALESCE(excluded.max_atk, digimons.max_atk),
        max_def = COALESCE(excluded.max_def, digimons.max_def),
        max_int = COALESCE(excluded.max_int, digimons.max_int),
        max_men = COALESCE(excluded.max_men, digimons.max_men),
        max_spd = COALESCE(excluded.max_spd, digimons.max_spd),
        image_path = COALESCE(excluded.image_path, digimons.image_path),
        source_url_ja = COALESCE(excluded.source_url_ja, digimons.source_url_ja),
        source_url_zh = COALESCE(excluded.source_url_zh, digimons.source_url_zh),
        description_ja = COALESCE(excluded.description_ja, digimons.description_ja),
        description_zh = COALESCE(excluded.description_zh, digimons.description_zh)
    ''');
    for (final r in records) {
      stmt.execute([
        r.id,
        r.dexNumber,
        r.nameJa,
        r.nameZh,
        r.nameEn,
        r.stageId,
        r.attributeId,
        r.typeId,
        r.elementId,
        r.personalityId,
        r.canDigiride == null ? null : (r.canDigiride! ? 1 : 0),
        r.dlcPack,
        r.maxHp,
        r.maxSp,
        r.maxAtk,
        r.maxDef,
        r.maxInt,
        r.maxMen,
        r.maxSpd,
        r.imagePath,
        r.sourceUrlJa,
        r.sourceUrlZh,
        r.descriptionJa,
        r.descriptionZh,
      ]);
    }
    stmt.dispose();
  }

  void _writeEvolutions(Database db, List<EvolutionRecord> records) {
    db.execute('DELETE FROM evolution_conditions');
    db.execute('DELETE FROM evolutions');
    final evoStmt = db.prepare(r'''
      INSERT INTO evolutions (
        from_id, to_id, direction, condition_text_ja, condition_text_zh
      ) VALUES (?, ?, ?, ?, ?)
    ''');
    final condStmt = db.prepare(r'''
      INSERT INTO evolution_conditions (
        evolution_id, kind, stat_id, threshold, digimon_id, personality_id, text_ja, text_zh
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''');
    for (final r in records) {
      evoStmt.execute([
        r.fromId,
        r.toId,
        r.direction,
        r.conditionTextJa,
        r.conditionTextZh,
      ]);
      final evoId = db.lastInsertRowId;
      for (final c in r.conditions) {
        condStmt.execute([
          evoId,
          c.kind,
          c.statId,
          c.threshold,
          c.digimonId,
          c.personalityId,
          c.textJa,
          c.textZh,
        ]);
      }
    }
    evoStmt.dispose();
    condStmt.dispose();
  }

  void _writeSkills(Database db, Iterable<SkillRecord> records) {
    final stmt = db.prepare(r'''
      INSERT INTO skills (
        id, name_ja, name_zh, name_en,
        element_id, category_id,
        power, accuracy, sp_cost,
        target_ja, target_zh,
        description_ja, description_zh
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        name_ja = excluded.name_ja,
        name_zh = COALESCE(excluded.name_zh, skills.name_zh),
        name_en = COALESCE(excluded.name_en, skills.name_en),
        element_id = COALESCE(excluded.element_id, skills.element_id),
        category_id = COALESCE(excluded.category_id, skills.category_id),
        power = COALESCE(excluded.power, skills.power),
        accuracy = COALESCE(excluded.accuracy, skills.accuracy),
        sp_cost = COALESCE(excluded.sp_cost, skills.sp_cost),
        target_ja = COALESCE(excluded.target_ja, skills.target_ja),
        target_zh = COALESCE(excluded.target_zh, skills.target_zh),
        description_ja = COALESCE(excluded.description_ja, skills.description_ja),
        description_zh = COALESCE(excluded.description_zh, skills.description_zh)
    ''');
    for (final r in records) {
      stmt.execute([
        r.id,
        r.nameJa,
        r.nameZh,
        r.nameEn,
        r.elementId,
        r.categoryId,
        r.power,
        r.accuracy,
        r.spCost,
        r.targetJa,
        r.targetZh,
        r.descriptionJa,
        r.descriptionZh,
      ]);
    }
    stmt.dispose();
  }

  void _writeDigimonSkills(Database db, List<DigimonSkillLink> records) {
    db.execute('DELETE FROM digimon_skills');
    final stmt = db.prepare(r'''
      INSERT INTO digimon_skills (
        digimon_id, skill_id, acquisition, learn_level, note_ja, note_zh
      ) VALUES (?, ?, ?, ?, ?, ?)
    ''');
    for (final r in records) {
      stmt.execute([
        r.digimonId,
        r.skillId,
        r.acquisition,
        r.learnLevel,
        r.noteJa,
        r.noteZh,
      ]);
    }
    stmt.dispose();
  }

  void _writePersonalities(Database db, Iterable<PersonalityRecord> records) {
    final stmt = db.prepare(r'''
      INSERT INTO personalities (
        id, name_ja, name_zh, up_stat_ja, up_stat_zh,
        down_stat_ja, down_stat_zh, description_ja, description_zh
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        name_ja = excluded.name_ja,
        name_zh = COALESCE(excluded.name_zh, personalities.name_zh),
        up_stat_ja = COALESCE(excluded.up_stat_ja, personalities.up_stat_ja),
        up_stat_zh = COALESCE(excluded.up_stat_zh, personalities.up_stat_zh),
        down_stat_ja = COALESCE(excluded.down_stat_ja, personalities.down_stat_ja),
        down_stat_zh = COALESCE(excluded.down_stat_zh, personalities.down_stat_zh),
        description_ja = COALESCE(excluded.description_ja, personalities.description_ja),
        description_zh = COALESCE(excluded.description_zh, personalities.description_zh)
    ''');
    for (final r in records) {
      stmt.execute([
        r.id,
        r.nameJa,
        r.nameZh,
        r.upStatJa,
        r.upStatZh,
        r.downStatJa,
        r.downStatZh,
        r.descriptionJa,
        r.descriptionZh,
      ]);
    }
    stmt.dispose();
  }

  void _writeStats(Database db, Iterable<StatRecord> records) {
    final stmt = db.prepare(r'''
      INSERT INTO stats (id, name_ja, name_zh, description_ja, description_zh)
      VALUES (?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        name_ja = excluded.name_ja,
        name_zh = COALESCE(excluded.name_zh, stats.name_zh),
        description_ja = COALESCE(excluded.description_ja, stats.description_ja),
        description_zh = COALESCE(excluded.description_zh, stats.description_zh)
    ''');
    for (final r in records) {
      stmt.execute([r.id, r.nameJa, r.nameZh, r.descriptionJa, r.descriptionZh]);
    }
    stmt.dispose();
  }

  void _writeGlossary(Database db, Iterable<GlossaryRecord> records) {
    final stmt = db.prepare(r'''
      INSERT INTO glossary (id, term_ja, term_zh, category, description_ja, description_zh)
      VALUES (?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        term_ja = excluded.term_ja,
        term_zh = COALESCE(excluded.term_zh, glossary.term_zh),
        category = COALESCE(excluded.category, glossary.category),
        description_ja = COALESCE(excluded.description_ja, glossary.description_ja),
        description_zh = COALESCE(excluded.description_zh, glossary.description_zh)
    ''');
    for (final r in records) {
      stmt.execute([
        r.id,
        r.termJa,
        r.termZh,
        r.category,
        r.descriptionJa,
        r.descriptionZh,
      ]);
    }
    stmt.dispose();
  }
}
