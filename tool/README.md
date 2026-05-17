# 工具腳本

這些是維護用的腳本，**不會** 被打包進 app。

## 一般流程

```
dart run tool/scrapers/sync.dart            # 全部來源全跑一次
dart run tool/scrapers/sync.dart --only=digimons,evolutions
dart run tool/scrapers/sync.dart --no-images   # 跳過圖片下載
```

執行完後 `assets/db/digimon.sqlite` 與 `assets/images/` 會被更新。
重新啟動 app 後（並刪除 user data 中的舊 DB），新資料會被載入。

## 各腳本

- `tool/scrapers/sync.dart` — 入口，協調所有來源
- `tool/scrapers/sources/game8.dart` — game8.jp 日文資料來源
- `tool/scrapers/sources/bahamut.dart` — 巴哈姆特中文補強
- `tool/scrapers/sources/ggameker.dart` — ggameker.tw 中文補強
- `tool/scrapers/init_db.dart` — 建立空白 schema 的 SQLite 檔

## 開發中

目前各 source 只有骨架，HTML 解析需依各站結構實作。
