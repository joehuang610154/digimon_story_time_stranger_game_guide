import 'package:fluent_ui/fluent_ui.dart';

import 'app/app_shell.dart';
import 'app/language.dart';
import 'app/theme.dart';
import 'data/app_database_runtime.dart';
import 'data/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final db = openAppDatabase();
  final repo = DigimonRepository(db);

  runApp(DigimonGuideApp(repository: repo));
}

class DigimonGuideApp extends StatefulWidget {
  const DigimonGuideApp({super.key, required this.repository});

  final DigimonRepository repository;

  @override
  State<DigimonGuideApp> createState() => _DigimonGuideAppState();
}

class _DigimonGuideAppState extends State<DigimonGuideApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  AppLanguage _language = AppLanguage.both;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: '數碼寶貝物語 時空異客 資料庫',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      // 透過 builder 把 LanguageScope 包在 Navigator 之上，
      // 這樣 push 出去的詳細頁 / 路線圖頁也吃得到語言設定。
      builder: (context, child) => LanguageScope(
        language: _language,
        child: child!,
      ),
      home: AppShell(
        repository: widget.repository,
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
        language: _language,
        onLanguageChanged: (lang) => setState(() => _language = lang),
      ),
    );
  }
}
