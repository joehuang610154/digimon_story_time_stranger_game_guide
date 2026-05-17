import 'package:fluent_ui/fluent_ui.dart';

/// 統一頁面外觀的容器：標題列 + 內容區，提供水平 padding，並注意 RWD。
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ScaffoldPage(
      header: PageHeader(
        title: Text(title, style: theme.typography.subtitle),
        leading: null,
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ),
      content: LayoutBuilder(
        builder: (context, constraints) {
          final pad = constraints.maxWidth < 600
              ? 12.0
              : constraints.maxWidth < 1000
                  ? 20.0
                  : 28.0;
          return Padding(
            padding: EdgeInsets.fromLTRB(pad, 0, pad, pad),
            child: subtitle == null
                ? child
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(subtitle!,
                          style: theme.typography.caption?.copyWith(
                              color:
                                  theme.resources.textFillColorSecondary)),
                      const SizedBox(height: 12),
                      Expanded(child: child),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
