/// 巴哈姆特中文補強 source。
///
/// 目標頁面參考：
/// - 全進化路線：https://forum.gamer.com.tw/C.php?bsn=7255&snA=10147
/// - 全 Digimon/技能查詢器：https://forum.gamer.com.tw/C.php?bsn=7255&snA=10129
///
/// 本檔僅骨架，HTML 解析需依各 thread 結構實作。
library;

import 'dart:io';

import '../http_util.dart';
import '../models.dart';

class BahamutSource {
  BahamutSource(this.fetcher);
  final HttpFetcher fetcher;

  static const evolutionThread =
      'https://forum.gamer.com.tw/C.php?bsn=7255&snA=10147';

  Future<void> collect(ScrapedBundle bundle) async {
    stdout.writeln('[bahamut] (中文對照解析尚未實作)');
    // TODO: 從 thread 第一篇文章中取出進化表，並把 nameZh 補回 bundle.digimons。
  }
}
