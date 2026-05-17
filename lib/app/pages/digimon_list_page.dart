import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';
import '../widgets/page_scaffold.dart';
import 'digimon_detail_page.dart';

class DigimonListPage extends StatefulWidget {
  const DigimonListPage({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<DigimonListPage> createState() => _DigimonListPageState();
}

class _ListData {
  _ListData(this.rows, this.lookups);
  final List<DigimonRow> rows;
  final LookupCache lookups;
}

class _DigimonListPageState extends State<DigimonListPage> {
  final _searchController = TextEditingController();
  late Future<_ListData> _future;

  String? _stageFilter;
  String? _attributeFilter;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<_ListData> _load() async {
    final rows = await widget.repository.allDigimons(
      keyword: _searchController.text,
    );
    final lookups = await widget.repository.loadLookups();
    return _ListData(rows, lookups);
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  List<DigimonRow> _applyFilters(List<DigimonRow> rows) {
    return rows.where((d) {
      if (_stageFilter != null &&
          _stageFilter!.isNotEmpty &&
          d.stageId != _stageFilter) {
        return false;
      }
      if (_attributeFilter != null &&
          _attributeFilter!.isNotEmpty &&
          d.attributeId != _attributeFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '圖鑑',
      subtitle: '所有可獲得數碼寶貝（中日對照）。可使用搜尋與篩選。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<_ListData>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: ProgressRing());
                }
                if (snap.hasError) {
                  return Center(child: Text('讀取失敗：${snap.error}'));
                }
                final data = snap.data;
                if (data == null) {
                  return const SizedBox.shrink();
                }
                final lookups = data.lookups;
                final rows = _applyFilters(data.rows);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FilterBar(
                      controller: _searchController,
                      stageValue: _stageFilter,
                      attrValue: _attributeFilter,
                      stages: lookups.stages.values.toList(),
                      attributes: lookups.attributes.values.toList(),
                      onSearchChanged: (_) => _reload(),
                      onStageChanged: (v) => setState(() => _stageFilter = v),
                      onAttrChanged: (v) => setState(() => _attributeFilter = v),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: rows.isEmpty
                          ? _EmptyHint(onSync: () {})
                          : _DigimonGrid(
                              rows: rows,
                              lookups: lookups,
                              onTap: (row) async {
                                await Navigator.of(context).push(
                                  FluentPageRoute(
                                    builder: (_) => DigimonDetailPage(
                                      repository: widget.repository,
                                      digimonId: row.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.controller,
    required this.stageValue,
    required this.attrValue,
    required this.stages,
    required this.attributes,
    required this.onSearchChanged,
    required this.onStageChanged,
    required this.onAttrChanged,
  });

  final TextEditingController controller;
  final String? stageValue;
  final String? attrValue;
  final List<StageRow> stages;
  final List<AttributeRow> attributes;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onStageChanged;
  final ValueChanged<String?> onAttrChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final compact = c.maxWidth < 720;
      final searchField = SizedBox(
        width: compact ? c.maxWidth : 320,
        child: TextBox(
          controller: controller,
          placeholder: '輸入名稱（日 / 中 / 英）',
          prefix: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(FluentIcons.search),
          ),
          onChanged: onSearchChanged,
        ),
      );
      final stageCombo = ComboBox<String>(
        value: stageValue,
        placeholder: const Text('世代'),
        items: [
          const ComboBoxItem(value: '', child: Text('全部世代')),
          ...stages.map((s) => ComboBoxItem(
                value: s.id,
                child: Text(s.nameZh ?? s.nameJa),
              )),
        ],
        onChanged: (v) => onStageChanged(v == '' ? null : v),
      );
      final attrCombo = ComboBox<String>(
        value: attrValue,
        placeholder: const Text('種族'),
        items: [
          const ComboBoxItem(value: '', child: Text('全部種族')),
          ...attributes.map((a) => ComboBoxItem(
                value: a.id,
                child: Text(a.nameZh ?? a.nameJa),
              )),
        ],
        onChanged: (v) => onAttrChanged(v == '' ? null : v),
      );
      if (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            searchField,
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: stageCombo),
              const SizedBox(width: 8),
              Expanded(child: attrCombo),
            ]),
          ],
        );
      }
      return Row(children: [
        searchField,
        const SizedBox(width: 12),
        stageCombo,
        const SizedBox(width: 12),
        attrCombo,
      ]);
    });
  }
}

class _DigimonGrid extends StatelessWidget {
  const _DigimonGrid({
    required this.rows,
    required this.lookups,
    required this.onTap,
  });

  final List<DigimonRow> rows;
  final LookupCache lookups;
  final ValueChanged<DigimonRow> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final maxCross = (c.maxWidth / 220).floor().clamp(1, 8);
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: maxCross,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: rows.length,
        itemBuilder: (context, i) {
          final d = rows[i];
          return _DigimonCard(
            row: d,
            lookups: lookups,
            onTap: () => onTap(d),
          );
        },
      );
    });
  }
}

class _DigimonCard extends StatelessWidget {
  const _DigimonCard({
    required this.row,
    required this.lookups,
    required this.onTap,
  });

  final DigimonRow row;
  final LookupCache lookups;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final stage = lookups.stages[row.stageId];
    final attr = lookups.attributes[row.attributeId];
    final subtitle = [
      stage?.nameZh ?? stage?.nameJa,
      attr?.nameZh ?? attr?.nameJa,
    ].whereType<String>().where((e) => e.isNotEmpty).join(' · ');
    return HoverButton(
      onPressed: onTap,
      builder: (context, states) {
        final hovered = states.isHovered;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: hovered
                ? theme.resources.subtleFillColorSecondary
                : theme.resources.cardBackgroundFillColorDefault,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.resources.cardStrokeColorDefault),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _DigimonImage(path: row.imagePath),
              ),
              const SizedBox(height: 8),
              BilingualText(
                zh: row.nameZh,
                ja: row.nameJa,
                style: theme.typography.bodyStrong,
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(subtitle, style: theme.typography.caption),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _DigimonImage extends StatelessWidget {
  const _DigimonImage({required this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) return _placeholder(context);
    return Image.asset(
      path!,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _placeholder(context),
    );
  }

  Widget _placeholder(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.resources.subtleFillColorTertiary,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Icon(FluentIcons.photo2, color: theme.inactiveColor),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.onSync});
  final VoidCallback onSync;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.database, size: 48),
          const SizedBox(height: 12),
          const Text('資料庫尚無內容。'),
          const SizedBox(height: 4),
          const Text('請先執行 tool/scrapers 將資料抓進 assets/db/digimon.sqlite。'),
        ],
      ),
    );
  }
}
