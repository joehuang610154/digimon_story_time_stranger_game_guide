import 'dart:math' as math;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import '../../data/app_database.dart';
import '../../data/repository.dart';
import '../language.dart';
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

  /// 待自動置中的 root id；非 null 時下一次 layout 完成會把該節點平移到視窗中央。
  String? _pendingCenterRoot;

  /// Ctrl+Click 啟動的「族譜交集」篩選：僅顯示同時屬於 root 與此節點族譜的節點。
  /// null = 無篩選。
  String? _filterNodeId;

  @override
  void initState() {
    super.initState();
    _rootId = widget.rootId;
    _pendingCenterRoot = _rootId;
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
    if (newRootId == _rootId) {
      if (_filterNodeId != null) {
        setState(() {
          _filterNodeId = null;
        });
      }
      return;
    }
    setState(() {
      _rootId = newRootId;
      _future = _load();
      _pendingCenterRoot = newRootId;
      _filterNodeId = null;
    });
  }

  void _handleNodeTap(String id) {
    final isCtrl = HardwareKeyboard.instance.isControlPressed;
    if (isCtrl) {
      setState(() {
        if (_filterNodeId == id || id == _rootId) {
          _filterNodeId = null;
        } else {
          _filterNodeId = id;
        }
        // 篩選切換會重新 layout，重置 pan 讓 root 回到視窗中央。
        _pendingCenterRoot = _rootId;
      });
      return;
    }
    _recenter(id);
  }

  void _clearFilter() {
    setState(() {
      _filterNodeId = null;
      _pendingCenterRoot = _rootId;
    });
  }

  /// 在 [edges] 限定的子圖內，計算 [id] 的祖先 + 自身 + 後代。
  Set<String> _familyOf(String id, Iterable<EvolutionRow> edges) {
    final outgoing = <String, List<String>>{};
    final incoming = <String, List<String>>{};
    for (final e in edges) {
      outgoing.putIfAbsent(e.fromId, () => []).add(e.toId);
      incoming.putIfAbsent(e.toId, () => []).add(e.fromId);
    }
    final result = <String>{id};
    final stack = <String>[id];
    while (stack.isNotEmpty) {
      final cur = stack.removeLast();
      for (final next in outgoing[cur] ?? const <String>[]) {
        if (result.add(next)) stack.add(next);
      }
    }
    stack.add(id);
    while (stack.isNotEmpty) {
      final cur = stack.removeLast();
      for (final prev in incoming[cur] ?? const <String>[]) {
        if (result.add(prev)) stack.add(prev);
      }
    }
    return result;
  }

  void _zoom(double factor) {
    final m = _xform.value.clone()..scaleByDouble(factor, factor, 1, 1);
    _xform.value = m;
  }

  void _resetView() {
    setState(() {
      _pendingCenterRoot = _rootId;
    });
  }

  void _centerOnRoot(_RouteLayout layout, Size viewport) {
    if (layout.nodes.isEmpty) {
      _pendingCenterRoot = null;
      return;
    }
    final node = layout.nodes.firstWhere(
      (n) => n.digimon.id == _rootId,
      orElse: () => layout.nodes.first,
    );
    final rootX = node.x + _RouteLayout.nodeWidth / 2;
    final rootY = node.y + _RouteLayout.nodeHeight / 2;
    final tx = viewport.width / 2 - rootX;
    final ty = viewport.height / 2 - rootY;
    _xform.value = Matrix4.identity()..translateByDouble(tx, ty, 0, 1);
    _pendingCenterRoot = null;
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
            if (_filterNodeId != null) ...[
              const SizedBox(width: 4),
              Tooltip(
                message: '清除篩選',
                child: IconButton(
                  icon: const Icon(FluentIcons.clear_filter),
                  onPressed: _clearFilter,
                ),
              ),
            ],
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
          // 篩選啟用時把 closure 收斂到「被選節點族譜」再 layout，
          // 讓非相關節點不只是被隱藏，整體排版也跟著收緊。
          // root 族譜即整個目前 closure，故直接以被選節點在 closure 內的族譜為視圖。
          final _RouteData viewData;
          if (_filterNodeId != null &&
              data.byId.containsKey(_filterNodeId)) {
            final visibleIds = _familyOf(_filterNodeId!, data.closure.edges);
            viewData = data.restrictedTo(visibleIds);
          } else {
            viewData = data;
          }
          final layout = _RouteLayout.compute(viewData);
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRect(
              child: LayoutBuilder(builder: (context, vc) {
                if (_pendingCenterRoot == _rootId) {
                  final viewport = Size(vc.maxWidth, vc.maxHeight);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    if (_pendingCenterRoot != _rootId) return;
                    _centerOnRoot(layout, viewport);
                  });
                }
                return Stack(
                  children: [
                    Positioned.fill(
                      child: InteractiveViewer(
                        transformationController: _xform,
                        minScale: 0.2,
                        maxScale: 3.0,
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(400),
                        child: _RouteCanvas(
                          data: viewData,
                          layout: layout,
                          rootId: _rootId,
                          filterNodeId: _filterNodeId,
                          onSelectNode: _handleNodeTap,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: _ControlsHint(filtered: _filterNodeId != null),
                    ),
                  ],
                );
              }),
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

  /// 回傳僅保留 [keepIds] 內節點與相關邊的子集，供 Ctrl+Click 過濾後 re-layout 使用。
  /// lookups / 條件 map 直接共用（多餘條目不影響顯示）。
  _RouteData restrictedTo(Set<String> keepIds) {
    final nodes =
        closure.nodes.where((n) => keepIds.contains(n.id)).toList();
    final edges = closure.edges
        .where((e) => keepIds.contains(e.fromId) && keepIds.contains(e.toId))
        .toList();
    return _RouteData(
      closure: EvolutionClosure(
        rootId: closure.rootId,
        nodes: nodes,
        edges: edges,
      ),
      lookups: lookups,
      byId: {for (final n in nodes) n.id: n},
      conditionJa: conditionJa,
      conditionZh: conditionZh,
    );
  }
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
/// 標準鏈（sortOrder 1–7：幼年期1 → 超究極体）排在上一行；非標準 stage
/// （アーマー体 / ハイブリッド体 / ヴァリアブル 等 sortOrder ≥ 8 或 NULL）
/// 拉到下一行，與標準鏈間有 [specialRowGap] 垂直間距。
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
  static const double specialRowGap = 80;
  static const int standardStageOrderMax = 7;

  final List<_NodePos> nodes;
  final List<_EdgePos> edges;
  final Size size;

  static bool _isSpecialOrder(int order) => order > standardStageOrderMax;

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
    final mainOrders =
        orders.where((o) => !_isSpecialOrder(o)).toList();
    final specialOrders = orders.where(_isSpecialOrder).toList();
    final hasMain = mainOrders.isNotEmpty;
    final hasSpecial = specialOrders.isNotEmpty;

    double rowWidth(int n) =>
        n == 0 ? 0 : n * nodeWidth + (n - 1) * columnGap;
    final mainWidth = rowWidth(mainOrders.length);
    final specialWidth = rowWidth(specialOrders.length);
    final contentWidth = math.max(mainWidth, specialWidth);
    // 每行各自水平置中於 contentWidth 內。
    final mainStartX = padding + (contentWidth - mainWidth) / 2;
    final specialStartX = padding + (contentWidth - specialWidth) / 2;

    final positions = <String, _NodePos>{};
    double maxMainColumnHeight = 0;
    double maxSpecialColumnHeight = 0;

    void placeRow(List<int> rowOrders, double startX, bool isSpecial) {
      for (var ci = 0; ci < rowOrders.length; ci++) {
        final list = byStage[rowOrders[ci]]!;
        final colHeight = list.length * nodeHeight +
            math.max(0, list.length - 1) * rowGap;
        if (isSpecial) {
          if (colHeight > maxSpecialColumnHeight) {
            maxSpecialColumnHeight = colHeight;
          }
        } else {
          if (colHeight > maxMainColumnHeight) {
            maxMainColumnHeight = colHeight;
          }
        }
        final x = startX + ci * (nodeWidth + columnGap);
        for (var ri = 0; ri < list.length; ri++) {
          final d = list[ri];
          positions[d.id] = _NodePos(
            digimon: d,
            x: x,
            y: ri * (nodeHeight + rowGap),
          );
        }
      }
    }

    placeRow(mainOrders, mainStartX, false);
    placeRow(specialOrders, specialStartX, true);

    // 每欄在所屬行內垂直置中。
    final specialRowTop = hasMain
        ? padding + maxMainColumnHeight + specialRowGap
        : padding;
    for (final order in orders) {
      final list = byStage[order]!;
      final colHeight = list.length * nodeHeight +
          math.max(0, list.length - 1) * rowGap;
      final isSpecial = _isSpecialOrder(order);
      final rowTop = isSpecial ? specialRowTop : padding;
      final rowHeight =
          isSpecial ? maxSpecialColumnHeight : maxMainColumnHeight;
      final yOffset = rowTop + (rowHeight - colHeight) / 2;
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

    final width =
        contentWidth == 0 ? padding * 2 + nodeWidth : padding * 2 + contentWidth;
    double height = padding * 2;
    if (hasMain) height += maxMainColumnHeight;
    if (hasMain && hasSpecial) height += specialRowGap;
    if (hasSpecial) height += maxSpecialColumnHeight;

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
    required this.filterNodeId,
    required this.onSelectNode,
  });

  final _RouteData data;
  final _RouteLayout layout;
  final String rootId;
  final String? filterNodeId;
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
                filtered: node.digimon.id == filterNodeId,
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
    required this.filtered,
    required this.onTap,
  });

  final DigimonRow digimon;
  final StageRow? stage;
  final String? conditionJa;
  final String? conditionZh;
  final bool selected;
  final bool filtered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filterColor =
        isDark ? const Color(0xFFFFB454) : const Color(0xFFCC6A00);
    final border = selected
        ? theme.accentColor.defaultBrushFor(theme.brightness)
        : (filtered
            ? filterColor
            : theme.resources.cardStrokeColorDefault);
    // 卡片底用不透明色，避免和頁面背景混在一起讓字看不清。
    final bg = selected
        ? (isDark
            ? const Color(0xFF1F3A55)
            : const Color(0xFFE6F0FB))
        : (filtered
            ? (isDark
                ? const Color(0xFF3B2E1A)
                : const Color(0xFFFFF4E0))
            : (isDark
                ? const Color(0xFF2B2B2B)
                : Colors.white));
    final textColor = theme.resources.textFillColorPrimary;
    final subtleColor = theme.resources.textFillColorSecondary;

    final lang = LanguageScope.of(context);
    final condFull = lang == AppLanguage.ja
        ? (conditionJa ?? conditionZh)
        : (conditionZh ?? conditionJa);
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
              width: selected || filtered ? 2 : (hover ? 1.4 : 1),
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

/// 遊戲風格的操作提示浮窗，固定在路線圖右下角。
class _ControlsHint extends StatelessWidget {
  const _ControlsHint({required this.filtered});

  final bool filtered;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark
        ? Colors.black.withValues(alpha: 0.62)
        : Colors.black.withValues(alpha: 0.72);
    const fg = Colors.white;
    final accent = theme.accentColor.defaultBrushFor(theme.brightness);

    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x55000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _HintRow(keys: const ['左鍵'], label: '以該節點為中心重繪', fg: fg),
            const SizedBox(height: 4),
            _HintRow(
              keys: const ['Ctrl', '+', '左鍵'],
              label: filtered ? '切換族譜交集篩選' : '只顯示與該節點族譜交集的路線',
              fg: fg,
              highlight: filtered ? accent : null,
            ),
            const SizedBox(height: 4),
            _HintRow(keys: const ['滾輪'], label: '縮放', fg: fg),
            const SizedBox(height: 4),
            _HintRow(keys: const ['拖曳'], label: '平移視圖', fg: fg),
          ],
        ),
      ),
    );
  }
}

class _HintRow extends StatelessWidget {
  const _HintRow({
    required this.keys,
    required this.label,
    required this.fg,
    this.highlight,
  });

  final List<String> keys;
  final String label;
  final Color fg;
  final Color? highlight;

  @override
  Widget build(BuildContext context) {
    final keyWidgets = <Widget>[];
    for (var i = 0; i < keys.length; i++) {
      final k = keys[i];
      if (k == '+') {
        keyWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text('+',
              style: TextStyle(
                color: fg.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              )),
        ));
      } else {
        keyWidgets.add(_KeyCap(label: k, fg: fg, highlight: highlight));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...keyWidgets,
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 11.5,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _KeyCap extends StatelessWidget {
  const _KeyCap({required this.label, required this.fg, this.highlight});

  final String label;
  final Color fg;
  final Color? highlight;

  @override
  Widget build(BuildContext context) {
    final borderColor = highlight ?? Colors.white.withValues(alpha: 0.35);
    final textColor = highlight ?? fg;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
