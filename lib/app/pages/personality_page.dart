import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';
import '../widgets/page_scaffold.dart';

class PersonalityPage extends StatefulWidget {
  const PersonalityPage({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<PersonalityPage> createState() => _PersonalityPageState();
}

class _PersonalityPageState extends State<PersonalityPage> {
  late Future<_Data> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_Data> _load() async {
    final personalities = await widget.repository.allPersonalities();
    final stats = await widget.repository.allStats();
    return _Data(personalities, stats);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '個性與才能值',
      subtitle: '性格（個性）對能力傾向的影響，以及才能值 / 養成參數說明。',
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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(text: '個性 / 性格'),
                if (data.personalities.isEmpty)
                  const Text('尚無資料。')
                else
                  _PersonalityTable(rows: data.personalities),
                const SizedBox(height: 24),
                _SectionHeader(text: '能力值 / 才能值'),
                if (data.stats.isEmpty)
                  const Text('尚無資料。')
                else
                  _StatList(rows: data.stats),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Data {
  _Data(this.personalities, this.stats);
  final List<PersonalityRow> personalities;
  final List<StatRow> stats;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(text, style: theme.typography.subtitle),
    );
  }
}

class _PersonalityTable extends StatelessWidget {
  const _PersonalityTable({required this.rows});
  final List<PersonalityRow> rows;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.resources.cardStrokeColorDefault),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('名稱', style: theme.typography.bodyStrong)),
                Expanded(flex: 3, child: Text('上昇', style: theme.typography.bodyStrong)),
                Expanded(flex: 3, child: Text('下降', style: theme.typography.bodyStrong)),
                Expanded(flex: 5, child: Text('說明', style: theme.typography.bodyStrong)),
              ],
            ),
          ),
          ...rows.map((r) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: BilingualText(zh: r.nameZh, ja: r.nameJa)),
                    Expanded(flex: 3, child: BilingualText(zh: r.upStatZh, ja: r.upStatJa)),
                    Expanded(flex: 3, child: BilingualText(zh: r.downStatZh, ja: r.downStatJa)),
                    Expanded(
                        flex: 5,
                        child: BilingualText(
                          zh: r.descriptionZh,
                          ja: r.descriptionJa,
                          style: theme.typography.caption,
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _StatList extends StatelessWidget {
  const _StatList({required this.rows});
  final List<StatRow> rows;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: theme.resources.cardStrokeColorDefault),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BilingualText(
                  zh: r.nameZh, ja: r.nameJa, style: theme.typography.bodyStrong),
              const SizedBox(height: 4),
              BilingualText(
                zh: r.descriptionZh,
                ja: r.descriptionJa,
                style: theme.typography.body,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
