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
          Text('資料來源', style: theme.typography.bodyStrong),
          const SizedBox(height: 8),
          Text(
            '本 app 內容資料整理自下列第三方攻略網站，著作權屬於各站及 / 或遊戲原權利人：',
            style: theme.typography.body,
          ),
          const SizedBox(height: 8),
          const _SourceLine(
            label: 'Game8（日文）',
            url: 'https://game8.jp/digimonstory-ts',
            usage: '日文名稱、能力值、進化、技能、圖片',
          ),
          const _SourceLine(
            label: '巴哈姆特 哈拉版（中文）',
            url: 'https://forum.gamer.com.tw/B.php?bsn=7255',
            usage: '中文名稱對照（規劃中）',
          ),
          const _SourceLine(
            label: 'ggameker.tw（中文）',
            url: 'https://ggameker.tw/pc-game/steam/time-stranger-field-guide/',
            usage: '中文圖鑑 / 進化路線補強（規劃中）',
          ),
          const SizedBox(height: 24),
          Text('版權聲明', style: theme.typography.bodyStrong),
          const SizedBox(height: 8),
          Text(
            '本工具為非營利的粉絲製作，未獲 Bandai Namco Entertainment Inc. 或'
            ' © Akiyoshi Hongo / Toei Animation 官方授權或背書。\n\n'
            '「Digimon」「數碼寶貝」「Digimon Story: Time Stranger」'
            '及相關角色、圖示、能力值、進化條件、技能等遊戲內資料著作權，'
            '皆屬 © Bandai Namco Entertainment Inc. / © Akiyoshi Hongo /'
            ' © Toei Animation 所有，本 app 僅作為查詢用途之整理與展示。\n\n'
            '若任何權利人認為本專案侵犯權利，請透過 GitHub issue 聯絡，'
            '會立即處理（移除 / 修改）。',
            style: theme.typography.caption,
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

class _SourceLine extends StatelessWidget {
  const _SourceLine({
    required this.label,
    required this.url,
    required this.usage,
  });

  final String label;
  final String url;
  final String usage;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label, style: theme.typography.bodyStrong),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(url, style: theme.typography.caption),
                Text(usage, style: theme.typography.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
