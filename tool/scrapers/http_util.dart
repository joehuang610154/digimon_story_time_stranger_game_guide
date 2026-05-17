/// 共用 HTTP utilities：簡單快取 + 限速。
library;

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class HttpFetcher {
  HttpFetcher({
    this.cacheDir = '.cache/http',
    this.minIntervalMs = 500,
    this.userAgent =
        'DigimonGuideBot/0.1 (+local; respects robots; for personal use)',
    this.defaultForceRefresh = false,
  });

  final String cacheDir;
  final int minIntervalMs;
  final String userAgent;

  /// `fetch` / `download` 未明確指定 `forceRefresh` 時的預設值。
  /// 由 `sync.dart --refresh` 設成 true 以忽略全部 HTTP cache。
  final bool defaultForceRefresh;

  DateTime _lastFetch = DateTime.fromMillisecondsSinceEpoch(0);

  Future<String> fetch(String url, {bool? forceRefresh}) async {
    final force = forceRefresh ?? defaultForceRefresh;
    final cacheKey = _keyFor(url);
    final cacheFile = File(p.join(cacheDir, cacheKey));
    if (!force && await cacheFile.exists()) {
      return cacheFile.readAsString();
    }

    await _throttle();
    final res = await http.get(Uri.parse(url), headers: {
      'User-Agent': userAgent,
      'Accept-Language': 'ja,zh-TW;q=0.9,en;q=0.8',
    });
    if (res.statusCode != 200) {
      throw HttpException(
          'GET $url failed: ${res.statusCode} ${res.reasonPhrase}');
    }
    final body = res.body;
    await cacheFile.parent.create(recursive: true);
    await cacheFile.writeAsString(body);
    return body;
  }

  Future<File> download(String url, String destPath,
      {bool? forceRefresh}) async {
    final force = forceRefresh ?? defaultForceRefresh;
    final f = File(destPath);
    if (!force && await f.exists()) return f;
    await _throttle();
    final res = await http.get(Uri.parse(url), headers: {'User-Agent': userAgent});
    if (res.statusCode != 200) {
      throw HttpException(
          'GET (binary) $url failed: ${res.statusCode}');
    }
    await f.parent.create(recursive: true);
    await f.writeAsBytes(res.bodyBytes, flush: true);
    return f;
  }

  String _keyFor(String url) {
    return url
        .replaceAll(RegExp(r'^https?://'), '')
        .replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');
  }

  Future<void> _throttle() async {
    final now = DateTime.now();
    final diff = now.difference(_lastFetch).inMilliseconds;
    if (diff < minIntervalMs) {
      await Future.delayed(Duration(milliseconds: minIntervalMs - diff));
    }
    _lastFetch = DateTime.now();
  }
}
