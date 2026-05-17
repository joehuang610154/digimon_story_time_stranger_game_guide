import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
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
    return _DetailData(d, evosOut, evosIn, skills, lookups);
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
            child: _DetailBody(data: data),
          );
        },
      ),
    );
  }
}

class _DetailData {
  _DetailData(
    this.digimon,
    this.evolutionsOut,
    this.evolutionsIn,
    this.skills,
    this.lookups,
  );
  final DigimonRow digimon;
  final List<EvolutionRow> evolutionsOut;
  final List<EvolutionRow> evolutionsIn;
  final List<DigimonSkillRow> skills;
  final LookupCache lookups;
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.data});
  final _DetailData data;

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

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BilingualText(
            zh: d.nameZh,
            ja: d.nameJa,
            style: theme.typography.titleLarge,
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
                        .map((e) => _EvolutionTile(row: e, fromHere: true))
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
                        .map((e) => _EvolutionTile(row: e, fromHere: false))
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: '習得技能',
            child: data.skills.isEmpty
                ? const Text('—')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: data.skills.map((s) {
                      final lv = s.learnLevel != null ? 'Lv ${s.learnLevel}' : s.acquisition;
                      return ListTile(
                        leading: const Icon(FluentIcons.lightning_bolt),
                        title: Text(s.skillId),
                        subtitle: Text(lv),
                      );
                    }).toList(),
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
    final stage = lookups.stages[digimon.stageId];
    final attr = lookups.attributes[digimon.attributeId];
    final type = lookups.types[digimon.typeId];
    final element = lookups.elements[digimon.elementId];
    final personality = lookups.personalities[digimon.personalityId];

    final rows = <MapEntry<String, Widget>>[
      MapEntry('圖鑑編號', Text(digimon.dexNumber?.toString() ?? '—')),
      MapEntry('世代', BilingualText(zh: stage?.nameZh, ja: stage?.nameJa)),
      MapEntry('種族', BilingualText(zh: attr?.nameZh, ja: attr?.nameJa)),
      MapEntry('タイプ', BilingualText(zh: type?.nameZh, ja: type?.nameJa)),
      MapEntry('属性', BilingualText(zh: element?.nameZh, ja: element?.nameJa)),
      MapEntry('基本性格',
          BilingualText(zh: personality?.nameZh, ja: personality?.nameJa)),
      MapEntry('デジライド',
          Text(digimon.canDigiride == null
              ? '—'
              : (digimon.canDigiride! ? '○' : '✕'))),
      MapEntry(
          'Lv99 ステータス',
          Text([
            if (digimon.maxHp != null) 'HP ${digimon.maxHp}',
            if (digimon.maxSp != null) 'SP ${digimon.maxSp}',
            if (digimon.maxAtk != null) 'ATK ${digimon.maxAtk}',
            if (digimon.maxDef != null) 'DEF ${digimon.maxDef}',
            if (digimon.maxInt != null) 'INT ${digimon.maxInt}',
            if (digimon.maxMen != null) 'MEN ${digimon.maxMen}',
            if (digimon.maxSpd != null) 'SPD ${digimon.maxSpd}',
          ].join('  /  '))),
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
                SizedBox(width: 140, child: Text(e.key)),
                Expanded(child: e.value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _EvolutionTile extends StatelessWidget {
  const _EvolutionTile({required this.row, required this.fromHere});
  final EvolutionRow row;
  final bool fromHere;

  @override
  Widget build(BuildContext context) {
    final targetId = fromHere ? row.toId : row.fromId;
    final condition = row.conditionTextZh ?? row.conditionTextJa;
    return ListTile(
      leading: Icon(fromHere ? FluentIcons.forward : FluentIcons.back),
      title: Text(targetId),
      subtitle: Text(condition ?? ''),
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
      child: const Icon(FluentIcons.photo2, size: 64),
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
