import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../language.dart';
import '../widgets/bilingual_text.dart';
import 'evolution_route_page.dart';

class DigimonDetailPage extends StatefulWidget {
  const DigimonDetailPage({
    super.key,
    required this.repository,
    required this.digimonId,
  });

  final DigimonRepository repository;
  final String digimonId;

  @override
  State<DigimonDetailPage> createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  late Future<_DetailData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_DetailData> _load() async {
    final d = await widget.repository.digimonById(widget.digimonId);
    if (d == null) {
      throw Exception('Digimon "${widget.digimonId}" 不存在');
    }
    final evosOut = await widget.repository.evolutionsFrom(widget.digimonId);
    final evosIn = await widget.repository.evolutionsTo(widget.digimonId);
    final skills = await widget.repository.skillsForDigimon(widget.digimonId);
    final lookups = await widget.repository.loadLookups();
    // 一次拿全部數碼寶貝與技能後做 map，避免 N+1 query。
    final allDigis = await widget.repository.allDigimons();
    final allSkillRows = await widget.repository.allSkills();
    return _DetailData(
      digimon: d,
      evolutionsOut: evosOut,
      evolutionsIn: evosIn,
      skills: skills,
      lookups: lookups,
      digimonsById: {for (final r in allDigis) r.id: r},
      skillsById: {for (final r in allSkillRows) r.id: r},
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('詳細資料'),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              onPressed: () {
                Navigator.of(context).push(FluentPageRoute(
                  builder: (_) => EvolutionRoutePage(
                    repository: widget.repository,
                    rootId: widget.digimonId,
                  ),
                ));
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.org, size: 14),
                  SizedBox(width: 6),
                  Text('進化路線圖'),
                ],
              ),
            ),
          ],
        ),
      ),
      content: FutureBuilder<_DetailData>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snap.hasError) {
            return Center(child: Text('讀取失敗：${snap.error}'));
          }
          final data = snap.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: _DetailBody(
              data: data,
              onOpenDigimon: (id) {
                Navigator.of(context).push(FluentPageRoute(
                  builder: (_) => DigimonDetailPage(
                    repository: widget.repository,
                    digimonId: id,
                  ),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}

class _DetailData {
  _DetailData({
    required this.digimon,
    required this.evolutionsOut,
    required this.evolutionsIn,
    required this.skills,
    required this.lookups,
    required this.digimonsById,
    required this.skillsById,
  });
  final DigimonRow digimon;
  final List<EvolutionRow> evolutionsOut;
  final List<EvolutionRow> evolutionsIn;
  final List<DigimonSkillRow> skills;
  final LookupCache lookups;
  final Map<String, DigimonRow> digimonsById;
  final Map<String, SkillRow> skillsById;
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.data, required this.onOpenDigimon});
  final _DetailData data;
  final ValueChanged<String> onOpenDigimon;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final d = data.digimon;
    return LayoutBuilder(builder: (context, c) {
      final twoCol = c.maxWidth > 900;
      final imageBlock = _DetailImage(path: d.imagePath);
      final infoBlock = _InfoTable(digimon: d, lookups: data.lookups);

      final headRow = twoCol
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 280, child: imageBlock),
                const SizedBox(width: 24),
                Expanded(child: infoBlock),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 240, child: imageBlock),
                const SizedBox(height: 16),
                infoBlock,
              ],
            );

      final sortedSkills = _sortSkills(data.skills);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: BilingualText(
                  zh: d.nameZh,
                  ja: d.nameJa,
                  style: theme.typography.titleLarge,
                ),
              ),
              if (d.dlcPack != null) ...[
                const SizedBox(width: 12),
                _DlcBadge(label: d.dlcPack!),
              ],
            ],
          ),
          const SizedBox(height: 12),
          headRow,
          const SizedBox(height: 24),
          _Section(
            title: '進化先',
            child: data.evolutionsOut.isEmpty
                ? const Text('—')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: data.evolutionsOut
                        .map((e) => _EvolutionTile(
                              row: e,
                              fromHere: true,
                              digimonsById: data.digimonsById,
                              lookups: data.lookups,
                              onTap: onOpenDigimon,
                            ))
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: '進化元',
            child: data.evolutionsIn.isEmpty
                ? const Text('—')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: data.evolutionsIn
                        .map((e) => _EvolutionTile(
                              row: e,
                              fromHere: false,
                              digimonsById: data.digimonsById,
                              lookups: data.lookups,
                              onTap: onOpenDigimon,
                            ))
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: '習得技能',
            child: sortedSkills.isEmpty
                ? const Text('—')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: sortedSkills
                        .map((s) => _SkillTile(
                              row: s,
                              skillsById: data.skillsById,
                              lookups: data.lookups,
                            ))
                        .toList(),
                  ),
          ),
          if (d.descriptionJa != null || d.descriptionZh != null) ...[
            const SizedBox(height: 16),
            _Section(
              title: '說明',
              child: BilingualText(
                zh: d.descriptionZh,
                ja: d.descriptionJa,
                style: theme.typography.body,
              ),
            ),
          ],
        ],
      );
    });
  }

  /// 排序習得技能：先 level 類（按等級遞增），其餘按 acquisition 字典序。
  List<DigimonSkillRow> _sortSkills(List<DigimonSkillRow> rows) {
    final sorted = [...rows];
    sorted.sort((a, b) {
      final aLvl = a.acquisition == 'level' && a.learnLevel != null;
      final bLvl = b.acquisition == 'level' && b.learnLevel != null;
      if (aLvl && bLvl) return a.learnLevel!.compareTo(b.learnLevel!);
      if (aLvl) return -1;
      if (bLvl) return 1;
      return a.acquisition.compareTo(b.acquisition);
    });
    return sorted;
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.resources.cardBackgroundFillColorDefault,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.resources.cardStrokeColorDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: theme.typography.bodyStrong),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _InfoTable extends StatelessWidget {
  const _InfoTable({required this.digimon, required this.lookups});
  final DigimonRow digimon;
  final LookupCache lookups;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final stage = lookups.stages[digimon.stageId];
    final attr = lookups.attributes[digimon.attributeId];
    final type = lookups.types[digimon.typeId];
    final element = lookups.elements[digimon.elementId];
    final personality = lookups.personalities[digimon.personalityId];

    final rows = <MapEntry<String, Widget>>[
      MapEntry('圖鑑編號', Text(digimon.dexNumber?.toString() ?? '—')),
      MapEntry('世代', BilingualText(zh: stage?.nameZh, ja: stage?.nameJa)),
      MapEntry('種族', BilingualText(zh: attr?.nameZh, ja: attr?.nameJa)),
      MapEntry('類型', BilingualText(zh: type?.nameZh, ja: type?.nameJa)),
      MapEntry('屬性', BilingualText(zh: element?.nameZh, ja: element?.nameJa)),
      MapEntry('性格',
          BilingualText(zh: personality?.nameZh, ja: personality?.nameJa)),
      MapEntry(
          '騎乘',
          Text(digimon.canDigiride == null
              ? '—'
              : (digimon.canDigiride! ? '○' : '✕'))),
      MapEntry('Lv99 能力', _StatsBlock(digimon: digimon)),
    ];

    return _Section(
      title: '基本資料',
      child: Column(
        children: rows.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 96,
                  child: Text(
                    e.key,
                    style: theme.typography.body?.copyWith(
                      color: theme.resources.textFillColorSecondary,
                    ),
                  ),
                ),
                Expanded(child: e.value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StatsBlock extends StatelessWidget {
  const _StatsBlock({required this.digimon});
  final DigimonRow digimon;

  static const _labels = <String, String>{
    'HP': 'maxHp',
    'SP': 'maxSp',
    'ATK': 'maxAtk',
    'DEF': 'maxDef',
    'INT': 'maxInt',
    'MEN': 'maxMen',
    'SPD': 'maxSpd',
  };

  int? _value(String key) {
    switch (key) {
      case 'maxHp':
        return digimon.maxHp;
      case 'maxSp':
        return digimon.maxSp;
      case 'maxAtk':
        return digimon.maxAtk;
      case 'maxDef':
        return digimon.maxDef;
      case 'maxInt':
        return digimon.maxInt;
      case 'maxMen':
        return digimon.maxMen;
      case 'maxSpd':
        return digimon.maxSpd;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final hasAny = _labels.values.any((k) => _value(k) != null);
    if (!hasAny) return const Text('—');
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _labels.entries.map((e) {
        final v = _value(e.value);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.resources.subtleFillColorSecondary,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: theme.resources.cardStrokeColorDefault),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                e.key,
                style: theme.typography.caption?.copyWith(
                  color: theme.resources.textFillColorSecondary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                v?.toString() ?? '—',
                style: theme.typography.bodyStrong,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _DlcBadge extends StatelessWidget {
  const _DlcBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final accent = theme.accentColor.defaultBrushFor(theme.brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Text(
        'DLC · $label',
        style: theme.typography.caption?.copyWith(color: accent),
      ),
    );
  }
}

class _EvolutionTile extends StatelessWidget {
  const _EvolutionTile({
    required this.row,
    required this.fromHere,
    required this.digimonsById,
    required this.lookups,
    required this.onTap,
  });

  final EvolutionRow row;
  final bool fromHere;
  final Map<String, DigimonRow> digimonsById;
  final LookupCache lookups;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final lang = LanguageScope.of(context);
    final targetId = fromHere ? row.toId : row.fromId;
    final target = digimonsById[targetId];
    final conditionRaw = lang == AppLanguage.ja
        ? (row.conditionTextJa ?? row.conditionTextZh)
        : (row.conditionTextZh ?? row.conditionTextJa);
    final condition = conditionRaw == null
        ? null
        : _summarizeConditionText(conditionRaw);
    final stage =
        target == null ? null : lookups.stages[target.stageId];
    final attr =
        target == null ? null : lookups.attributes[target.attributeId];
    final subtitleParts = <String>[
      if (stage != null) pickName(lang, zh: stage.nameZh, ja: stage.nameJa),
      if (attr != null) pickName(lang, zh: attr.nameZh, ja: attr.nameJa),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: HoverButton(
        onPressed: () => onTap(targetId),
        cursor: SystemMouseCursors.click,
        builder: (context, states) {
          final hover = states.isHovered;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: hover
                  ? theme.resources.subtleFillColorSecondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: theme.resources.cardStrokeColorDefault),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  fromHere ? FluentIcons.forward : FluentIcons.back,
                  size: 14,
                  color: theme.resources.textFillColorSecondary,
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 56,
                  height: 56,
                  child: _DetailImage(path: target?.imagePath),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BilingualText(
                        zh: target?.nameZh,
                        ja: target?.nameJa ?? targetId,
                        style: theme.typography.bodyStrong,
                      ),
                      if (subtitleParts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitleParts.join(' · '),
                            style: theme.typography.caption?.copyWith(
                              color: theme.resources.textFillColorSecondary,
                            ),
                          ),
                        ),
                      if (condition != null && condition.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            condition,
                            style: theme.typography.caption,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SkillTile extends StatelessWidget {
  const _SkillTile({
    required this.row,
    required this.skillsById,
    required this.lookups,
  });

  final DigimonSkillRow row;
  final Map<String, SkillRow> skillsById;
  final LookupCache lookups;

  String _acquisitionLabel() {
    if (row.acquisition == 'level' && row.learnLevel != null) {
      return 'Lv ${row.learnLevel}';
    }
    switch (row.acquisition) {
      case 'inherit':
        return '遺傳';
      case 'event':
        return '事件';
      case 'item':
        return '道具';
      case 'level':
        return '升等';
      default:
        return row.acquisition;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final lang = LanguageScope.of(context);
    final skill = skillsById[row.skillId];
    final element =
        skill?.elementId == null ? null : lookups.elements[skill!.elementId];
    final category = skill?.categoryId == null
        ? null
        : lookups.skillCategories[skill!.categoryId];
    final captionParts = <String>[
      if (element != null) pickName(lang, zh: element.nameZh, ja: element.nameJa),
      if (category != null)
        pickName(lang, zh: category.nameZh, ja: category.nameJa),
      if (skill?.power != null) '威力 ${skill!.power}',
      if (skill?.spCost != null) 'SP ${skill!.spCost}',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              FluentIcons.lightning_bolt,
              size: 14,
              color: theme.resources.textFillColorSecondary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BilingualText(
                  zh: skill?.nameZh,
                  ja: skill?.nameJa ?? row.skillId,
                  style: theme.typography.bodyStrong,
                ),
                if (captionParts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      captionParts.join(' · '),
                      style: theme.typography.caption?.copyWith(
                        color: theme.resources.textFillColorSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: theme.resources.subtleFillColorSecondary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _acquisitionLabel(),
              style: theme.typography.caption,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailImage extends StatelessWidget {
  const _DetailImage({required this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    Widget placeholder = Container(
      decoration: BoxDecoration(
        color: theme.resources.subtleFillColorTertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: const Icon(FluentIcons.photo2, size: 32),
    );

    if (path == null || path!.isEmpty) return placeholder;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        path!,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}

/// 把進化條件原文壓成適合 inline 顯示的精簡版：
/// - 過濾純標題行（如 ＜進化＞）
/// - 連續換行壓成單一換行
String _summarizeConditionText(String raw) {
  final lines = raw
      .split(RegExp(r'[\r\n]+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .where((s) => !RegExp(r'^[＜<].+[＞>]$').hasMatch(s))
      .toList();
  return lines.join('\n');
}
