import 'package:fluent_ui/fluent_ui.dart';

FluentThemeData buildDarkTheme() {
  return FluentThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.teal,
    visualDensity: VisualDensity.standard,
    focusTheme: const FocusThemeData(glowFactor: 0),
  );
}

FluentThemeData buildLightTheme() {
  return FluentThemeData(
    brightness: Brightness.light,
    accentColor: Colors.teal,
    visualDensity: VisualDensity.standard,
    focusTheme: const FocusThemeData(glowFactor: 0),
  );
}
