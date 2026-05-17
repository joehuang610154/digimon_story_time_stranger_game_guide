import 'dart:math' as math;

import 'package:fluent_ui/fluent_ui.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../widgets/bilingual_text.dart';

/// 單隻數碼寶貝的進化路線圖：以選定為中心，往左展示全部祖先、往右展示
/// 全部後代，依世代 sortOrder 分欄。可 pan / zoom，點任一節點重新以該
/// 節點為中心重繪。
class EvolutionRoutePage extends StatefulWidget {
  const EvolutionRoutePage({
    super.key,
    required this.repository,
    required this.rootId,
  });

  final DigimonRepository repository;
  final String rootId;

  @override
  State<EvolutionRoutePage> createState() => _EvolutionRoutePageState();
}

class _EvolutionRoutePageState extends State<EvolutionRoutePage> {
  late String _rootId;
  late Future<_RouteData> _future;
  final TransformationController _xform = TransformationController();

  @override
  void initState() {
    super.initState();
    _rootId = widget.rootId;
    _future = _load();
  }

  @override
  void dispose() {
    _xform.dispose();
    super.dispose();
  }

  Future<_RouteData> _load() async {
    final closure = await widget.repository.evolutionClosureOf(_rootId);
    final lookups = await widget.repository.loadLookups();
    final byId = {for (final n in closure.nodes) n.id: n};
    // 進化條件 per-target 唯一（已驗證：451 個 target 沒有歧異），
    // 因此可以安全地把條件 dedupe 到 target id 顯示在節點上。
    final conditionJa = <String, String>{};
    final conditionZh = <String, String>{};
    for (final e in closure.edges) {
      if (e.conditionTextJa != null && conditionJa[e.toId] == null) {
        conditionJa[e.toId] = e.conditionTextJa!;
      }
      if (e.conditionTextZh != null && conditionZh[e.toId] == null) {
        conditionZh[e.toId] = e.conditionTextZh!;
      }
    }
    return _RouteData(
      closure: closure,
      lookups: lookups,
      byId: byId,
      conditionJa: conditionJa,
      conditionZh: conditionZh,
    );
  }

  void _recenter(String newRootId) {
    if (newRootId == _rootId) return;
    setState(() {
      _rootId = newRootId;
      _future = _load();
      _xform.value = Matrix4.identity();
    });
  }

  void _zoom(double factor) {
    final m = _xform.value.clone()..scaleByDouble(factor, factor, 1, 1);
    _xform.value = m;
  }

  void _resetView() {
    _xform.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('進化路線圖'),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: '放大',
              child: IconButton(
                icon: const Icon(FluentIcons.add),
                onPressed: () => _zoom(1.2),
              ),
            ),
            const SizedBox(width: 4),
            Tooltip(
              message: '縮小',
              child: IconButton(
                icon: const Icon(FluentIcons.remove),
                onPressed: () => _zoom(1 / 1.2),
              ),
            ),
            const SizedBox(width: 4),
            Tooltip(
              message: '重設視圖',
              child: IconButton(
                icon: const Icon(FluentIcons.fit_page),
                onPressed: _resetView,
              ),
            ),
          ],
        ),
      ),
      content: FutureBuilder<_RouteData>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snap.hasError) {
            return Center(child: Text('讀取失敗：${snap.error}'));
          }
          final data = snap.data!;
          if (data.closure.nodes.length <= 1 && data.closure.edges.isEmpty) {
            return const Center(child: Text('此數碼寶貝沒有可顯示的進化關係。'));
          }
          final layout = _RouteLayout.compute(data);
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRect(
              child: InteractiveViewer(
                transformationController: _xform,
                minScale: 0.2,
                maxScale: 3.0,
                constrained: false,
                boundaryMargin: const EdgeInsets.all(400),
                child: _RouteCanvas(
                  data: data,
                  layout: layout,
                  rootId: _rootId,
                  onSelectNode: _recenter,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RouteData {
  _RouteData({
    required this.closure,
    required this.lookups,
    required this.byId,
    required this.conditionJa,
    required this.conditionZh,
  });

  final EvolutionClosure closure;
  final LookupCache lookups;
  final Map<String, DigimonRow> byId;
  /// to_id -> 進化成此 Digimon 的條件原文（日 / 中）。
  final Map<String, String> conditionJa;
  final Map<String, String> conditionZh;
}

class _NodePos {
  _NodePos({required this.digimon, required this.x, required this.y});
  final DigimonRow digimon;
  double x;
  double y;
}

class _EdgePos {
  _EdgePos({
    required this.evolution,
    required this.from,
    required this.to,
  });

  final EvolutionRow evolution;
  final _NodePos from;
  final _NodePos to;
}

/// 路線圖的座標 layout。所有節點以 stage.sortOrder 分欄，欄內依 dex 排序。
class _RouteLayout {
  _RouteLayout({
    required this.nodes,
    required this.edges,
    required this.size,
  });

  static const double nodeWidth = 180;
  static const double nodeHeight = 200;
  static const double columnGap = 96;
  static const double rowGap = 16;
  static const double padding = 24;

  final List<_NodePos> nodes;
  final List<_EdgePos> edges;
  final Size size;

  static _RouteLayout compute(_RouteData data) {
    final byStage = <int, List<DigimonRow>>{};
    int fallbackOrder = 9000;
    for (final d in data.closure.nodes) {
      final order = data.lookups.stages[d.stageId]?.sortOrder ?? fallbackOrder;
      byStage.putIfAbsent(order, () => []).add(d);
    }
    for (final list in byStage.values) {
      list.sort((a, b) {
        final ax = a.dexNumber ?? 1 << 30;
        final bx = b.dexNumber ?? 1 << 30;
        if (ax != bx) return ax.compareTo(bx);
        return a.nameJa.compareTo(b.nameJa);
      });
    }

    final orders = byStage.keys.toList()..sort();
    final positions = <String, _NodePos>{};
    double maxColumnHeight = 0;

    for (var ci = 0; ci < orders.length; ci++) {
      final list = byStage[orders[ci]]!;
      final colHeight = list.length * nodeHeight +
          math.max(0, list.length - 1) * rowGap;
      if (colHeight > maxColumnHeight) maxColumnHeight = colHeight;
      final x = padding + ci * (nodeWidth + columnGap);
      for (var ri = 0; ri < list.length; ri++) {
        final d = list[ri];
        positions[d.id] = _NodePos(
          digimon: d,
          x: x,
          y: ri * (nodeHeight + rowGap),
        );
      }
    }

    // 把每欄垂直置中對齊到 maxColumnHeight。
    for (final order in orders) {
      final list = byStage[order]!;
      final colHeight = list.length * nodeHeight +
          math.max(0, list.length - 1) * rowGap;
      final yOffset = padding + (maxColumnHeight - colHeight) / 2;
      for (final d in list) {
        positions[d.id]!.y += yOffset;
      }
    }

    final edges = <_EdgePos>[];
    for (final e in data.closure.edges) {
      final from = positions[e.fromId];
      final to = positions[e.toId];
      if (from == null || to == null) continue;
      edges.add(_EdgePos(evolution: e, from: from, to: to));
    }

    final width = orders.isEmpty
        ? padding * 2 + nodeWidth
        : padding * 2 + orders.length * nodeWidth +
            math.max(0, orders.length - 1) * columnGap;
    final height = padding * 2 + maxColumnHeight;

    return _RouteLayout(
      nodes: positions.values.toList(),
      edges: edges,
      size: Size(width, height),
    );
  }
}

class _RouteCanvas extends StatelessWidget {
  const _RouteCanvas({
    required this.data,
    required this.layout,
    required this.rootId,
    required this.onSelectNode,
  });

  final _RouteData data;
  final _RouteLayout layout;
  final String rootId;
  final ValueChanged<String> onSelectNode;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final edgeColor =
        theme.resources.textFillColorSecondary.withValues(alpha: 0.55);
    final highlightColor = theme.accentColor.defaultBrushFor(theme.brightness);

    return SizedBox(
      width: layout.size.width,
      height: layout.size.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _EdgePainter(
                layout: layout,
                rootId: rootId,
                baseColor: edgeColor,
                highlightColor: highlightColor,
              ),
            ),
          ),
          for (final node in layout.nodes)
            Positioned(
              left: node.x,
              top: node.y,
              width: _RouteLayout.nodeWidth,
              height: _RouteLayout.nodeHeight,
              child: _NodeCard(
                digimon: node.digimon,
                stage: data.lookups.stages[node.digimon.stageId],
                conditionJa: data.conditionJa[node.digimon.id],
                conditionZh: data.conditionZh[node.digimon.id],
                selected: node.digimon.id == rootId,
                onTap: () => onSelectNode(node.digimon.id),
              ),
            ),
        ],
      ),
    );
  }
}

class _EdgePainter extends CustomPainter {
  _EdgePainter({
    required this.layout,
    required this.rootId,
    required this.baseColor,
    required this.highlightColor,
  });

  final _RouteLayout layout;
  final String rootId;
  final Color baseColor;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in layout.edges) {
      final touchesRoot =
          e.from.digimon.id == rootId || e.to.digimon.id == rootId;
      final color = touchesRoot ? highlightColor : baseColor;
      final paint = Paint()
        ..color = color
        ..strokeWidth = touchesRoot ? 2.2 : 1.4
        ..style = PaintingStyle.stroke;

      final start = Offset(
        e.from.x + _RouteLayout.nodeWidth,
        e.from.y + _RouteLayout.nodeHeight / 2,
      );
      final end = Offset(
        e.to.x,
        e.to.y + _RouteLayout.nodeHeight / 2,
      );
      final dx = (end.dx - start.dx).abs();
      final cp1 = Offset(start.dx + dx * 0.45, start.dy);
      final cp2 = Offset(end.dx - dx * 0.45, end.dy);

      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, end.dx, end.dy);
      canvas.drawPath(path, paint);

      _drawArrow(canvas, cp2, end, color);
    }
  }

  void _drawArrow(Canvas canvas, Offset from, Offset tip, Color color) {
    const headLen = 9.0;
    const headHalfW = 5.0;
    final dir = tip - from;
    final len = dir.distance;
    if (len < 0.001) return;
    final ux = dir.dx / len;
    final uy = dir.dy / len;
    final base = Offset(tip.dx - ux * headLen, tip.dy - uy * headLen);
    final left = Offset(base.dx + -uy * headHalfW, base.dy + ux * headHalfW);
    final right = Offset(base.dx - -uy * headHalfW, base.dy - ux * headHalfW);
    final p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(p, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _EdgePainter old) =>
      old.layout != layout ||
      old.rootId != rootId ||
      old.baseColor != baseColor ||
      old.highlightColor != highlightColor;
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({
    required this.digimon,
    required this.stage,
    required this.conditionJa,
    required this.conditionZh,
    required this.selected,
    required this.onTap,
  });

  final DigimonRow digimon;
  final StageRow? stage;
  final String? conditionJa;
  final String? conditionZh;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final border = selected
        ? theme.accentColor.defaultBrushFor(theme.brightness)
        : theme.resources.cardStrokeColorDefault;
    // 卡片底用不透明色，避免和頁面背景混在一起讓字看不清。
    final bg = selected
        ? (isDark
            ? const Color(0xFF1F3A55)
            : const Color(0xFFE6F0FB))
        : (isDark
            ? const Color(0xFF2B2B2B)
            : Colors.white);
    final textColor = theme.resources.textFillColorPrimary;
    final subtleColor = theme.resources.textFillColorSecondary;

    final condFull = conditionZh ?? conditionJa;
    final condSummary = condFull == null ? null : _summarizeCondition(condFull);

    return HoverButton(
      onPressed: onTap,
      cursor: SystemMouseCursors.click,
      builder: (context, states) {
        final hover = states.isHovered;
        final card = AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: border,
              width: selected ? 2 : (hover ? 1.4 : 1),
            ),
            boxShadow: selected || hover
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 76,
                child: _NodeImage(path: digimon.imagePath),
              ),
              const SizedBox(height: 4),
              BilingualText(
                zh: digimon.nameZh,
                ja: digimon.nameJa,
                style: theme.typography.caption?.copyWith(
                  fontSize: 11,
                  color: textColor,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
                fallbackStyle: theme.typography.caption?.copyWith(
                  fontSize: 10,
                  color: subtleColor,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 1,
                color: theme.resources.dividerStrokeColorDefault,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: condSummary == null || condSummary.isEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Text('—',
                            style: theme.typography.caption?.copyWith(
                                fontSize: 10, color: subtleColor)),
                      )
                    : Text(
                        condSummary,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.caption?.copyWith(
                          fontSize: 10,
                          height: 1.3,
                          color: textColor,
                        ),
                      ),
              ),
            ],
          ),
        );
        if (condFull == null) return card;
        return Tooltip(message: condFull, child: card);
      },
    );
  }

  /// 把條件原文壓成適合放在卡片裡的精簡版：
  /// - 過濾掉純標題行（如 ＜進化＞）
  /// - 連續換行壓成單一換行
  /// - 同一行內的多重「以上」條件保留
  String _summarizeCondition(String raw) {
    final lines = raw
        .split(RegExp(r'[\r\n]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .where((s) => !RegExp(r'^[＜<].+[＞>]$').hasMatch(s))
        .toList();
    return lines.join('\n');
  }
}

class _NodeImage extends StatelessWidget {
  const _NodeImage({required this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final placeholder = Container(
      decoration: BoxDecoration(
        color: theme.resources.subtleFillColorTertiary,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: const Icon(FluentIcons.photo2, size: 28),
    );
    if (path == null || path!.isEmpty) return placeholder;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(
        path!,
        fit: BoxFit.contain,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}
