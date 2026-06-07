import 'package:fluent_ui/fluent_ui.dart';

import '../language.dart';

/// 依目前語言模式顯示名稱：
/// - 中日對照：「亞古獸 / アグモン」
/// - 中文 / 日文：只顯示對應語言（缺該語言時 fallback 到另一邊）
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

    final hasZh = zh != null && zh!.isNotEmpty;
    final hasJa = ja != null && ja!.isNotEmpty;
    if (!hasZh && !hasJa) {
      return Text('—', style: baseStyle);
    }

    final lang = LanguageScope.of(context);
    // 單語模式：顯示選定語言，缺則 fallback 到另一邊。
    if (lang == AppLanguage.zh) {
      return Text(hasZh ? zh! : ja!, style: baseStyle);
    }
    if (lang == AppLanguage.ja) {
      return Text(hasJa ? ja! : zh!, style: baseStyle);
    }

    // 中日對照模式：只有一邊時顯示該邊；兩邊都有則 zh / ja 並陳。
    if (!hasZh) {
      return Text(ja!, style: baseStyle);
    }
    if (!hasJa) {
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
