import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';
import '../widgets/page_scaffold.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillData {
  _SkillData(this.rows, this.lookups);
  final List<SkillRow> rows;
  final LookupCache lookups;
}

class _SkillPageState extends State<SkillPage> {
  final _search = TextEditingController();
  late Future<_SkillData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_SkillData> _load() async {
    final rows = await widget.repository.allSkills(keyword: _search.text);
    final lookups = await widget.repository.loadLookups();
    return _SkillData(rows, lookups);
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '技能',
      subtitle: '所有スキル / 技能。包含威力、命中、SP、目標、屬性等資料。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 360,
            child: TextBox(
              controller: _search,
              placeholder: '搜尋技能（日 / 中）',
              prefix: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(FluentIcons.search),
              ),
              onChanged: (_) => _reload(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<_SkillData>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: ProgressRing());
                }
                if (snap.hasError) {
                  return Center(child: Text('讀取失敗：${snap.error}'));
                }
                final data = snap.data;
                if (data == null || data.rows.isEmpty) {
                  return const Center(child: Text('尚無技能資料。'));
                }
                return _SkillTable(rows: data.rows, lookups: data.lookups);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillTable extends StatelessWidget {
  const _SkillTable({required this.rows, required this.lookups});
  final List<SkillRow> rows;
  final LookupCache lookups;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.resources.cardStrokeColorDefault),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView.separated(
        itemCount: rows.length + 1,
        separatorBuilder: (_, __) => Divider(
          style: DividerThemeData(
            decoration: BoxDecoration(color: theme.resources.cardStrokeColorDefault),
          ),
        ),
        itemBuilder: (context, i) {
          if (i == 0) return _headerRow(theme);
          final r = rows[i - 1];
          return _dataRow(theme, r);
        },
      ),
    );
  }

  Widget _headerRow(FluentThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('名稱', style: theme.typography.bodyStrong)),
          Expanded(flex: 2, child: Text('屬性', style: theme.typography.bodyStrong)),
          Expanded(flex: 2, child: Text('類別', style: theme.typography.bodyStrong)),
          SizedBox(width: 64, child: Text('威力', style: theme.typography.bodyStrong)),
          SizedBox(width: 64, child: Text('命中', style: theme.typography.bodyStrong)),
          SizedBox(width: 64, child: Text('SP', style: theme.typography.bodyStrong)),
          Expanded(flex: 4, child: Text('效果', style: theme.typography.bodyStrong)),
        ],
      ),
    );
  }

  Widget _dataRow(FluentThemeData theme, SkillRow r) {
    final element = lookups.elements[r.elementId];
    final category = lookups.skillCategories[r.categoryId];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 3, child: BilingualText(zh: r.nameZh, ja: r.nameJa)),
          Expanded(flex: 2, child: BilingualText(zh: element?.nameZh, ja: element?.nameJa)),
          Expanded(flex: 2, child: BilingualText(zh: category?.nameZh, ja: category?.nameJa)),
          SizedBox(width: 64, child: Text(r.power?.toString() ?? '—')),
          SizedBox(width: 64, child: Text(r.accuracy?.toString() ?? '—')),
          SizedBox(width: 64, child: Text(r.spCost?.toString() ?? '—')),
          Expanded(
            flex: 4,
            child: BilingualText(
              zh: r.descriptionZh,
              ja: r.descriptionJa,
              style: theme.typography.caption,
            ),
          ),
        ],
      ),
    );
  }
}
