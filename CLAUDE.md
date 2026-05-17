# Digimon Story: Time Stranger 攻略 DB — Repo 約定

Windows-only Flutter app，做數碼寶貝物語 時空異客的養成「資料庫」（查詢工具，不是流程攻略）。
使用者玩日文版，所有資料一律中日對照。

## 技術棧

| 用途       | 套件                                | 備註                                                       |
| ---------- | ----------------------------------- | ---------------------------------------------------------- |
| UI         | `fluent_ui` 4.15+                   | Windows 11 風格；**不要 import `package:flutter/material.dart`** |
| DB         | `drift` + `sqlite3_flutter_libs`    | 型別安全 + migration                                       |
| Scraper    | 獨立 `dart run tool/scrapers/...`   | 不在 app 內爬蟲                                            |

關鍵相依：Flutter 3.35.4 / Dart 3.9.2 / fluent_ui 4.15.1 / drift 2.31.0 / intl 0.20.2（被 fluent_ui transitively 鎖死）。

fluent_ui 4.15 gotcha：
- `NavigationView` 用 `titleBar:` 不是 `appBar:`
- `TitleBar` 取代 `NavigationAppBar`
- `DragToMoveArea` 已被移除

## Schema 單一來源

drift table definitions（`lib/data/tables/*.dart`）是 **唯一** 的 schema source of truth。

改 schema 時：
1. 改 `lib/data/tables/*.dart`
2. 跑 `dart run build_runner build` 重新生成 `lib/data/app_database.g.dart`
3. 如果改的是新增/刪欄位，同步更新 `tool/scrapers/models.dart`（純 Dart record）與 `tool/scrapers/writer.dart`（INSERT 欄位列）
4. `dart run tool/scrapers/sync.dart --reset --bump-version=<short-label>` 重建 DB + bump 版本
5. `assets/db/digimon.sqlite` 與 `lib/data/app_database_runtime.dart` 內的 `bundledDbVersion` 都會更新；rebuild app 才會帶入

> ⚠️ `init_db.dart` 已不再手寫 CREATE TABLE — 它呼叫 `AppDatabase.forFile(...)` 讓 drift Migrator 從上面的 table definitions 自動建表。所以 schema 不可能與 runtime 不同步。

## App 啟動時的 DB 版本檢查

- `assets/db/digimon.sqlite` 預載打進 bundle
- 首次啟動：複製到 user data dir，並寫入 `db_version.txt`
- 之後每次啟動：比對 `bundledDbVersion` 與 `db_version.txt`，不同就重新複製

因此 schema 或重要資料改動後務必 bump `bundledDbVersion`（用 `sync.dart --bump-version=<label>`），否則 dev 機重啟看不到新 DB。

## Scraper 工作流（`tool/scrapers/`）

| 檔案                  | 角色                                                         |
| --------------------- | ------------------------------------------------------------ |
| `init_db.dart`        | 用 drift Migrator 建空 schema                                |
| `http_util.dart`      | `.cache/http/` 檔案快取 + 500ms 限速；`defaultForceRefresh` 預設 false |
| `models.dart`         | 純 Dart 資料模型（不依賴 drift），給 source 寫入             |
| `sources/game8.dart`  | 日文主來源 — **已完整實作**                                  |
| `sources/bahamut.dart` / `sources/ggameker.dart` | 中文補強 — **仍 stub**                  |
| `writer.dart`         | 寫進 SQLite；lookup 先寫；upsert 用 `COALESCE(excluded.x, x)` 讓多 source 互補不互蓋 |
| `quality_report.dart` | sync 收尾的固定品質報告                                      |
| `inspect_db.dart`     | dev 隨手檢查 DB 用                                           |
| `sync.dart`           | 入口                                                         |

常用：

```sh
# 增量寫入（不刪舊資料，最常用）
dart run tool/scrapers/sync.dart

# 改 schema 後完整重建
dart run tool/scrapers/sync.dart --reset --bump-version=<short-label>

# 只跑某 source
dart run tool/scrapers/sync.dart --only=game8

# 忽略 HTTP cache（game8 內容有更新時）
dart run tool/scrapers/sync.dart --refresh

# 取樣除錯（只解析前 N 個個別頁）
dart run tool/scrapers/sync.dart --only=game8 --limit=5

# 不下載圖片
dart run tool/scrapers/sync.dart --no-images

# 看 DB 內容
dart run tool/scrapers/inspect_db.dart --schema
dart run tool/scrapers/inspect_db.dart --table=digimons --sample=3

# 單獨跑品質報告（不重新爬）
dart run tool/scrapers/quality_report.dart
```

`sync.dart` 結束時固定印一份品質報告，包含：digimons 數量是否=465、缺圖、DLC tagging gap、lookup 表是否混入異常 tag、evolution_conditions 結構化覆蓋率、name_zh 補強進度、FK orphans。每次 sync 後比對這份報告即可發現回歸。

## 雙語欄位慣例

- 任何 user-visible 欄位都用 `xxxJa` + `xxxZh` 雙欄
- UI 用 `lib/app/widgets/bilingual_text.dart`，自動處理只有一邊的情況
- Writer upsert 用 `COALESCE(excluded.x, table.x)`，保證後跑的 source 只能補空、不能覆蓋

## 圖片

- Scraper 下載到 `assets/images/digimon/<id>.webp`，跟著 app bundle 一起打包
- DB 內 `image_path` 存完整 asset path（例：`assets/images/digimon/g8_725202.webp`）
- UI 直接 `Image.asset(row.imagePath)`
- pubspec 已註冊 `assets/images/digimon/`

## ID 設計

- 目前所有 digimon id 為 `g8_<gameId>` 前綴（例：`g8_725202`）
- 未來會 migration 換成英文 slug（如 `agumon`），等 bahamut/ggameker 提供中/英對照表後處理
- Lookup id（stages/attributes/types/elements/personalities）直接用日文 raw text 為 PK

## 已知資料 gap / 瑕疵

- **DLC dex 458–475 黑色版本族**：game8 DLC 頁未涵蓋，`dlc_pack` 仍 NULL
- **編輯筆誤**：「ハイブリッド体」與「ハイブリット体」、「NODATA」與「NODATE」並存（game8 上游問題）
- **一覧頁 4-tag 順序錯亂**：某些特殊角色（如 stage=ヴァリアブル、attribute=ハイブリッド体）一覧頁 tag 順序不一致導致欄位錯置
- **digimons.element_id 100% NULL**：game8 個別頁基本情報無屬性欄位
- **evolution_conditions 52% kind='special'**：條件文字解析器覆蓋率還可以提升
- **中文 source 未實作**：bahamut / ggameker 仍是 stub；`name_zh` 全部 NULL

## 不要做的事

- 不要在 `lib/` 引入 `package:flutter/material.dart`（用 fluent_ui 對應品）
- 不要手寫 SQL 重複 drift schema（`init_db.dart` 已從 drift 自動生）
- 不要繞過 `sync.dart` 直接改 `assets/db/digimon.sqlite`（會被下一次 sync 覆蓋）
- 不要忘記 `--bump-version` — 改完 DB 沒 bump，dev 機重啟看不到改動
