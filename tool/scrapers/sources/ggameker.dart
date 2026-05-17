/// ggameker.tw 中文補強 source。
///
/// 目標頁面：
/// - 圖鑑完整收錄：https://ggameker.tw/pc-game/steam/time-stranger-field-guide/
/// - 進化路線：https://ggameker.tw/pc-game/steam/time-stranger-evolution/
library;

import 'dart:io';

import '../http_util.dart';
import '../models.dart';

class GgamekerSource {
  GgamekerSource(this.fetcher);
  final HttpFetcher fetcher;

  static const fieldGuideUrl =
      'https://ggameker.tw/pc-game/steam/time-stranger-field-guide/';
  static const evolutionUrl =
      'https://ggameker.tw/pc-game/steam/time-stranger-evolution/';

  Future<void> collect(ScrapedBundle bundle) async {
    stdout.writeln('[ggameker] (中文對照解析尚未實作)');
    // TODO: 從圖鑑頁取得中文名稱，與 game8 的日文資料 join。
  }
}
