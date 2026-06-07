/// 同步入口：依參數呼叫各 source，把結果寫回 assets/db/digimon.sqlite。
///
/// ```
/// dart run tool/scrapers/sync.dart                            # 增量寫入既有 DB（upsert）
/// dart run tool/scrapers/sync.dart --reset                    # 先刪掉 DB 重建空 schema 再寫
/// dart run tool/scrapers/sync.dart --only=game8
/// dart run tool/scrapers/sync.dart --refresh                  # 忽略 .cache/http
/// dart run tool/scrapers/sync.dart --no-images
/// dart run tool/scrapers/sync.dart --db=path/to.sqlite
/// dart run tool/scrapers/sync.dart --bump-version=add-bahamut # schema 或資料有變動時，bump 版本字串讓 app 重灌 DB
/// ```
library;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'http_util.dart';
import 'init_db.dart';
import 'models.dart';
import 'quality_report.dart';
import 'sources/bahamut.dart';
import 'sources/game8.dart';
import 'sources/ggameker.dart';
import 'sources/ilaopo.dart';
import 'sources/zh_terms.dart';
import 'writer.dart';

Future<void> main(List<String> argv) async {
  final parser = ArgParser()
    ..addOption('db',
        defaultsTo: p.join('assets', 'db', 'digimon.sqlite'),
        help: 'SQLite 輸出路徑。')
    ..addOption('only',
        help: '只執行特定 source，以逗號分隔（game8,bahamut,ggameker）。')
    ..addOption('limit',
        help: 'game8 個別頁解析上限（除錯/取樣用）。')
    ..addFlag('skip-details',
        defaultsTo: false, help: '只跑一覧頁，跳過個別頁。')
    ..addFlag('refresh', defaultsTo: false, help: '忽略 HTTP 快取。')
    ..addFlag('images', defaultsTo: true, help: '是否下載圖片（預設 true）。')
    ..addFlag('reset',
        defaultsTo: false,
        help: '寫入前先刪掉 DB，用 drift schema 重建空表（適合 schema 變動後）。')
    ..addOption('bump-version',
        help: '同步完成後將 lib/data/app_database_runtime.dart 內的 '
            'bundledDbVersion 改成 YYYY-MM-DD-<label>，'
            '讓 app 下次啟動重新從 assets bundle 複製 DB。')
    ..addFlag('help', abbr: 'h', negatable: false);

  final args = parser.parse(argv);
  if (args['help'] as bool) {
    stdout.writeln(parser.usage);
    return;
  }

  final dbPath = args['db'] as String;

  if (args['reset'] as bool) {
    stdout.writeln('[reset] 重建空 DB ($dbPath) ...');
    await initDatabase(dbPath);
  }

  final onlyRaw = args['only'] as String?;
  final only = onlyRaw == null || onlyRaw.isEmpty
      ? null
      : onlyRaw.split(',').map((s) => s.trim()).toSet();
  bool run(String source) => only == null || only.contains(source);

  final limit = int.tryParse(args['limit'] as String? ?? '');
  final skipDetails = args['skip-details'] as bool;

  final fetcher = HttpFetcher(defaultForceRefresh: args['refresh'] as bool);
  final bundle = ScrapedBundle();

  if (run('game8')) {
    await Game8Source(fetcher, detailLimit: limit, skipDetails: skipDetails)
        .collect(bundle);
  }
  if (run('bahamut')) {
    await BahamutSource(fetcher).collect(bundle);
  }
  if (run('ggameker')) {
    await GgamekerSource(fetcher).collect(bundle);
  }
  if (run('ilaopo')) {
    await IlaopoSource(fetcher).collect(bundle);
  }
  if (run('zh_terms')) {
    await ZhTermsSource().collect(bundle);
  }

  if (args['images'] as bool) {
    await _downloadImages(fetcher, bundle);
  }

  SqliteWriter(dbPath).write(bundle);

  runQualityReport(dbPath);

  final bumpLabel = args['bump-version'] as String?;
  if (bumpLabel != null && bumpLabel.isNotEmpty) {
    _bumpBundledDbVersion(bumpLabel);
  }

  stdout.writeln('Done.');
}

Future<void> _downloadImages(HttpFetcher fetcher, ScrapedBundle bundle) async {
  const dir = 'assets/images/digimon';
  await Directory(dir).create(recursive: true);

  final pending =
      bundle.digimons.values.where((d) => d.imageUrl != null).toList();
  stdout.writeln('[images] 開始下載 ${pending.length} 張 ...');

  var done = 0;
  var failed = 0;
  for (final d in pending) {
    final ext = _extFromUrl(d.imageUrl!) ?? '.webp';
    final filePath = '$dir/${d.id}$ext';
    try {
      await fetcher.download(d.imageUrl!, filePath);
      d.imagePath = filePath;
    } catch (e) {
      stderr.writeln('[images] ${d.id} 失敗：$e');
      failed++;
    }
    done++;
    if (done % 50 == 0 || done == pending.length) {
      stdout.writeln('[images]   進度 $done / ${pending.length}');
    }
  }
  stdout.writeln('[images] 完成，失敗 $failed');
}

String? _extFromUrl(String url) {
  final m = RegExp(r'\.(webp|png|jpg|jpeg|gif)(?:/|$|\?)').firstMatch(url);
  if (m == null) return null;
  return '.${m.group(1)}';
}

/// 將 `lib/data/app_database_runtime.dart` 內的
/// `const bundledDbVersion = '...';` 改為 `YYYY-MM-DD-<label>`。
void _bumpBundledDbVersion(String label) {
  final file = File(p.join('lib', 'data', 'app_database_runtime.dart'));
  if (!file.existsSync()) {
    stderr.writeln('[bump-version] 找不到 ${file.path}，跳過。');
    return;
  }
  final src = file.readAsStringSync();
  // 只配對行首（避開 /// 註解內的範例字串）。
  final pattern =
      RegExp(r"^const bundledDbVersion = '[^']*';", multiLine: true);
  if (!pattern.hasMatch(src)) {
    stderr.writeln(
        "[bump-version] 在 ${file.path} 找不到 \"const bundledDbVersion = '...';\" "
        '行首，跳過。請確認該行是否被改過格式。');
    return;
  }
  final now = DateTime.now();
  final dateStr = '${now.year.toString().padLeft(4, '0')}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.day.toString().padLeft(2, '0')}';
  final newVersion = '$dateStr-$label';
  final updated =
      src.replaceFirst(pattern, "const bundledDbVersion = '$newVersion';");
  file.writeAsStringSync(updated);
  stdout.writeln('[bump-version] bundledDbVersion -> $newVersion');
}
