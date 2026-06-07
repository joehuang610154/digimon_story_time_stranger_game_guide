import 'package:fluent_ui/fluent_ui.dart';

/// App 顯示語言模式。資料一律雙語儲存（xxxJa / xxxZh），此設定只決定 UI 怎麼呈現。
enum AppLanguage {
  /// 中日對照（預設）— 名稱、說明等主要欄位同時顯示中、日。
  both,

  /// 只顯示中文（缺中文時 fallback 到日文）。
  zh,

  /// 只顯示日文（缺日文時 fallback 到中文）。
  ja;

  /// 導覽列快速切換按鈕用的短標籤。
  String get shortLabel => switch (this) {
        AppLanguage.both => '中日',
        AppLanguage.zh => '中',
        AppLanguage.ja => '日',
      };

  /// 設定頁 / 選單用的完整標籤。
  String get fullLabel => switch (this) {
        AppLanguage.both => '中日對照',
        AppLanguage.zh => '中文',
        AppLanguage.ja => '日本語',
      };

  /// 快速切換按鈕：循環 中日 → 中 → 日 → 中日。
  AppLanguage get next => switch (this) {
        AppLanguage.both => AppLanguage.zh,
        AppLanguage.zh => AppLanguage.ja,
        AppLanguage.ja => AppLanguage.both,
      };
}

/// 把目前語言模式往下傳遞給整棵 widget tree。改變時會通知所有依賴的 widget 重建。
class LanguageScope extends InheritedWidget {
  const LanguageScope({
    super.key,
    required this.language,
    required super.child,
  });

  final AppLanguage language;

  /// 取得目前語言模式；無 scope 時 fallback 為中日對照。
  static AppLanguage of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    return scope?.language ?? AppLanguage.both;
  }

  @override
  bool updateShouldNotify(LanguageScope oldWidget) =>
      language != oldWidget.language;
}

/// 在「只能放單一字串」的緊湊位置（ComboBox 項目、卡片副標題、技能 / 進化標籤等）
/// 依語言模式挑一個名稱。中日對照模式維持原本「優先中文、缺則日文」的單值行為，
/// 完整雙語呈現留給 [BilingualText]。
String pickName(AppLanguage lang, {String? zh, String? ja}) {
  final z = (zh != null && zh.isNotEmpty) ? zh : null;
  final j = (ja != null && ja.isNotEmpty) ? ja : null;
  return switch (lang) {
    AppLanguage.ja => j ?? z ?? '',
    AppLanguage.zh || AppLanguage.both => z ?? j ?? '',
  };
}
