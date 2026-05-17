import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/page_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return PageScaffold(
      title: '設定',
      child: ListView(
        children: [
          Text('主題', style: theme.typography.bodyStrong),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _themeChip(context, ThemeMode.system, '跟隨系統'),
              _themeChip(context, ThemeMode.light, '淺色'),
              _themeChip(context, ThemeMode.dark, '深色'),
            ],
          ),
          const SizedBox(height: 24),
          Text('資料同步', style: theme.typography.bodyStrong),
          const SizedBox(height: 8),
          InfoBar(
            title: const Text('資料同步透過 tool/scrapers 進行'),
            content: const Text(
              '請在專案根目錄執行：dart run tool/scrapers/sync.dart\n'
              '完成後 assets/db/digimon.sqlite 會被更新。重新啟動 app 即可載入新版本。',
            ),
            severity: InfoBarSeverity.info,
            isLong: true,
          ),
          const SizedBox(height: 24),
          Text('版本', style: theme.typography.bodyStrong),
          const SizedBox(height: 4),
          const Text('數碼寶貝物語 時空異客 資料庫 v1.0.0'),
        ],
      ),
    );
  }

  Widget _themeChip(BuildContext context, ThemeMode m, String label) {
    final selected = themeMode == m;
    return ToggleButton(
      checked: selected,
      onChanged: (_) => onThemeModeChanged(m),
      child: Text(label),
    );
  }
}
