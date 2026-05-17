import 'package:fluent_ui/fluent_ui.dart';

/// 顯示 中日對照 的文字，例： 「亞古獸 / アグモン」
class BilingualText extends StatelessWidget {
  const BilingualText({
    super.key,
    required this.zh,
    required this.ja,
    this.style,
    this.fallbackStyle,
  });

  final String? zh;
  final String? ja;
  final TextStyle? style;
  final TextStyle? fallbackStyle;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final baseStyle = style ?? theme.typography.body!;
    final subtleStyle = fallbackStyle ??
        theme.typography.caption!
            .copyWith(color: theme.resources.textFillColorSecondary);

    if ((zh == null || zh!.isEmpty) && (ja == null || ja!.isEmpty)) {
      return Text('—', style: baseStyle);
    }
    if (zh == null || zh!.isEmpty) {
      return Text(ja!, style: baseStyle);
    }
    if (ja == null || ja!.isEmpty) {
      return Text(zh!, style: baseStyle);
    }
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: zh, style: baseStyle),
          TextSpan(text: '  /  $ja', style: subtleStyle),
        ],
      ),
    );
  }
}
