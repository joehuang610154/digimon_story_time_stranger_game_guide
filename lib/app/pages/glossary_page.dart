import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';
import '../widgets/page_scaffold.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {
  late Future<List<GlossaryRow>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.allGlossary();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '術語表',
      subtitle: '養成相關名詞中日對照（友情值、蓄積值、エージェントランク、才能值 等）。',
      child: FutureBuilder<List<GlossaryRow>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snap.hasError) {
            return Center(child: Text('讀取失敗：${snap.error}'));
          }
          final rows = snap.data ?? const [];
          if (rows.isEmpty) {
            return const Center(child: Text('尚無術語資料。'));
          }
          return ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) {
              final r = rows[i];
              return _GlossaryTile(row: r);
            },
          );
        },
      ),
    );
  }
}

class _GlossaryTile extends StatelessWidget {
  const _GlossaryTile({required this.row});
  final GlossaryRow row;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.resources.cardStrokeColorDefault),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BilingualText(
                zh: row.termZh,
                ja: row.termJa,
                style: theme.typography.bodyStrong,
              ),
              if (row.category != null && row.category!.isNotEmpty) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.accentColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(row.category!, style: theme.typography.caption),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          BilingualText(
            zh: row.descriptionZh,
            ja: row.descriptionJa,
            style: theme.typography.body,
          ),
        ],
      ),
    );
  }
}
