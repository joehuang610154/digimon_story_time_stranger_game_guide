import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';
import '../widgets/page_scaffold.dart';
import 'digimon_detail_page.dart';

/// 進化路線總覽。
class EvolutionPage extends StatefulWidget {
  const EvolutionPage({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<EvolutionPage> createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  late Future<_Data> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_Data> _load() async {
    final digimons = await widget.repository.allDigimons();
    final evos = await widget.repository.allEvolutions();
    final byId = {for (final d in digimons) d.id: d};
    return _Data(byId, evos);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '進化路線',
      subtitle: '所有進化邊 (from → to)，可點擊任一節點開啟詳細頁。',
      child: FutureBuilder<_Data>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snap.hasError) {
            return Center(child: Text('讀取失敗：${snap.error}'));
          }
          final data = snap.data!;
          if (data.evolutions.isEmpty) {
            return const Center(child: Text('尚無進化資料。'));
          }
          return ListView.separated(
            itemCount: data.evolutions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) {
              final e = data.evolutions[i];
              final from = data.byId[e.fromId];
              final to = data.byId[e.toId];
              return _EvoRow(
                from: from,
                to: to,
                row: e,
                onTap: (id) {
                  Navigator.of(context).push(FluentPageRoute(
                    builder: (_) => DigimonDetailPage(
                      repository: widget.repository,
                      digimonId: id,
                    ),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _Data {
  _Data(this.byId, this.evolutions);
  final Map<String, DigimonRow> byId;
  final List<EvolutionRow> evolutions;
}

class _EvoRow extends StatelessWidget {
  const _EvoRow({
    required this.from,
    required this.to,
    required this.row,
    required this.onTap,
  });

  final DigimonRow? from;
  final DigimonRow? to;
  final EvolutionRow row;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.resources.cardStrokeColorDefault),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: HyperlinkButton(
              onPressed: () => onTap(row.fromId),
              child: BilingualText(zh: from?.nameZh, ja: from?.nameJa ?? row.fromId),
            ),
          ),
          const Icon(FluentIcons.forward),
          Expanded(
            child: HyperlinkButton(
              onPressed: () => onTap(row.toId),
              child: BilingualText(zh: to?.nameZh, ja: to?.nameJa ?? row.toId),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 240,
            child: Text(
              row.conditionTextZh ?? row.conditionTextJa ?? '',
              style: theme.typography.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
