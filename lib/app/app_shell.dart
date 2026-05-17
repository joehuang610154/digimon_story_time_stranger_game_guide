import 'package:fluent_ui/fluent_ui.dart';

import '../data/repository.dart';
import 'pages/digimon_list_page.dart';
import 'pages/evolution_page.dart';
import 'pages/glossary_page.dart';
import 'pages/personality_page.dart';
import 'pages/settings_page.dart';
import 'pages/skill_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.repository,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final DigimonRepository repository;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final repo = widget.repository;

    return NavigationView(
      titleBar: const TitleBar(
        title: Text('數碼寶貝物語 時空異客 資料庫'),
      ),
      pane: NavigationPane(
        selected: _index,
        onChanged: (i) => setState(() => _index = i),
        displayMode: PaneDisplayMode.auto,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.bullseye_target),
            title: const Text('圖鑑'),
            body: DigimonListPage(repository: repo),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.org),
            title: const Text('進化路線'),
            body: EvolutionPage(repository: repo),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.lightning_bolt),
            title: const Text('技能'),
            body: SkillPage(repository: repo),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.contact),
            title: const Text('個性與才能值'),
            body: PersonalityPage(repository: repo),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.dictionary),
            title: const Text('術語表'),
            body: GlossaryPage(repository: repo),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('設定'),
            body: SettingsPage(
              themeMode: widget.themeMode,
              onThemeModeChanged: widget.onThemeModeChanged,
            ),
          ),
        ],
      ),
    );
  }
}
