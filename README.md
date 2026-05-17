# 數碼寶貝物語 時空異客 攻略資料庫

Windows-only Flutter app，做《**數碼寶貝物語 時空異客** / **Digimon Story: Time Stranger**》的養成「資料庫」 —— 圖鑑、進化路線、技能、個性才能值、術語表的查詢工具，**不是流程攻略**。

使用者玩日文版，所有 user-visible 欄位採中日對照。

---

## ⚠️ 版權聲明 / Disclaimer

本專案是 **非營利的粉絲製作工具**，並 **未** 獲得 Bandai Namco Entertainment Inc. 或 © Akiyoshi Hongo, Toei Animation 的官方授權或背書。

- 「**Digimon**」「**數碼寶貝**」「**Digimon Story: Time Stranger**」「**デジモンストーリー タイムストレンジャー**」 等名稱、角色、圖示，皆為 © Bandai Namco Entertainment Inc. / © Akiyoshi Hongo / © Toei Animation 所有。
- 本 app 中的數碼寶貝圖片、能力值、進化條件、技能數值等遊戲內資料，**著作權皆屬上述原權利人**，本專案僅作為查詢用途之整理與展示。
- 本 app 內的資料是從下方列出之第三方攻略網站擷取彙整，**著作權屬於各原始網站**。本專案在介面上明確標示資料來源；若任何權利人認為本專案侵犯權利，請開 issue 聯絡，我們會立即處理（移除 / 修改 / 重新整理來源）。
- 本專案的 **程式碼**（`lib/`、`tool/`、scripts）以 MIT License 釋出；但 **資料（`assets/db/`、`assets/images/`）不適用 MIT**，請參考下方「資料來源」一節。
- 本工具 **不可用於商業用途**，請勿在販售性質的服務上散布內含資料的版本。

如果你只想看程式碼結構或 fork 來做別款遊戲的類似工具，那部分隨意；但請不要把內含資料的 build artifact 上架到任何商店。

---

## 資料來源 / Data Sources

本 app 內容資料整理自下列第三方攻略網站，著作權屬於各站及 / 或遊戲原權利人：

| 來源 | URL | 用途 | 狀態 |
| --- | --- | --- | --- |
| **Game8（日文）** | https://game8.jp/digimonstory-ts | 日文名稱、圖鑑編號、世代 / 種族 / タイプ / 属性、Lv99 能力值、進化邊、技能、圖片 | ✅ 已實作 |
| **巴哈姆特 哈拉版（中文）** | https://forum.gamer.com.tw/B.php?bsn=7255 | 中文名稱對照、進化表補強 | 🚧 規劃中 |
| **ggameker.tw（中文）** | https://ggameker.tw/pc-game/steam/time-stranger-field-guide/ | 中文圖鑑 / 進化路線補強 | 🚧 規劃中 |

擷取策略：
- 走本地 `.cache/http/` 檔案快取 + 500 ms throttle，最大程度減少對來源站的請求負擔；同一頁通常只抓一次。
- User-Agent 為一般瀏覽器標頭；若來源站希望 identify，請開 issue 告知。
- 多 source upsert 用 `COALESCE(excluded.x, table.x)`，後跑的 source **只能補空、不能覆蓋** 既有資料。

如果你是上述任何網站的權利人，**希望本專案停止使用其資料 / 圖片 / 修改 attribution 寫法**，請透過 GitHub issue 聯絡，我會在 7 天內處理。

---

## 技術棧

| 用途       | 套件                                | 備註 |
| ---------- | ----------------------------------- | ---- |
| UI         | `fluent_ui` 4.15+                   | Windows 11 風格；不使用 `package:flutter/material.dart` |
| DB         | `drift` + `sqlite3_flutter_libs`    | 型別安全 + migration |
| Scraper    | 獨立 `dart run tool/scrapers/...`   | 不在 app 內爬蟲 |

關鍵相依：Flutter 3.35.4 / Dart 3.9.2 / fluent_ui 4.15.1 / drift 2.31.0 / intl 0.20.2。

---

## 快速開始

需求：Windows + Flutter SDK 3.35+ (含 Windows desktop support)。

```sh
# 取得相依
flutter pub get

# 跑起來（dev）
flutter run -d windows

# 打 release（產 exe）
flutter build windows --release
# 輸出在 build\windows\x64\runner\Release\
```

App 預設帶著 `assets/db/digimon.sqlite`（透過 scraper 預先建好），首次啟動會把它複製到 user data dir（`%APPDATA%\<app>\db\digimon.sqlite`）。

---

## 資料同步 / Scraper

爬蟲 **不在 app 內**，是獨立的 `dart run` 腳本。

```sh
# 增量寫入（最常用）
dart run tool/scrapers/sync.dart

# 改 schema 後完整重建
dart run tool/scrapers/sync.dart --reset --bump-version=<short-label>

# 只跑某 source
dart run tool/scrapers/sync.dart --only=game8

# 忽略 HTTP cache（來源網站內容有更新時）
dart run tool/scrapers/sync.dart --refresh

# 取樣 debug（只解析前 N 個個別頁）
dart run tool/scrapers/sync.dart --only=game8 --limit=5

# 不下載圖片
dart run tool/scrapers/sync.dart --no-images

# 看 DB 內容
dart run tool/scrapers/inspect_db.dart --schema
dart run tool/scrapers/inspect_db.dart --table=digimons --sample=3
```

`sync.dart` 結束會固定印一份 **品質報告**（digimons 數量、缺圖、DLC tagging gap、進化條件結構化覆蓋率、`name_zh` 補強進度、FK orphans 等），方便每次 sync 後比對是否回歸。

詳見 [tool/README.md](tool/README.md) 與 [CLAUDE.md](CLAUDE.md)。

---

## 專案結構

```
lib/
  main.dart                       # 入口
  app/                            # UI 層（fluent_ui）
    app_shell.dart                # NavigationView shell
    theme.dart
    pages/                        # 圖鑑 / 進化 / 技能 / 個性 / 術語 / 設定
    widgets/
      bilingual_text.dart         # 中日對照顯示 helper
      page_scaffold.dart
  data/                           # DB 層（drift）
    app_database.dart             # @DriftDatabase 宣告
    app_database.g.dart           # build_runner 產出（勿手改）
    app_database_runtime.dart     # bundle 複製 / 版本檢查
    repository.dart               # query API
    tables/                       # ★ Schema 單一來源
      digimons.dart
      evolutions.dart
      lookups.dart
      personalities.dart
      skills.dart

tool/scrapers/                    # 維運用，不打包進 app
  init_db.dart                    # drift Migrator 建空 schema
  http_util.dart                  # 檔案快取 + throttle
  models.dart                     # 純 Dart 中介模型
  writer.dart                     # COALESCE upsert
  quality_report.dart
  inspect_db.dart
  sync.dart                       # 入口
  sources/
    game8.dart                    # ✅ 主來源
    bahamut.dart                  # 🚧 stub
    ggameker.dart                 # 🚧 stub

assets/
  db/digimon.sqlite               # 預載 DB（隨 app bundle）
  images/digimon/<id>.webp        # 圖片（隨 app bundle）
```

Schema 唯一來源為 `lib/data/tables/*.dart`；`init_db.dart` 直接呼叫 `AppDatabase.forFile(...)` 讓 drift Migrator 建表，所以 runtime schema 不可能與 scraper schema 不同步。

---

## 已知資料 gap

- **DLC dex 458–475 黑色版本族**：game8 DLC 頁未涵蓋，`dlc_pack` 仍 NULL
- **digimons.element_id 100% NULL**：game8 個別頁基本情報無屬性欄位
- **evolution_conditions 52% 為 `kind='special'`**：條件文字解析器覆蓋率還可提升
- **中文 source 未實作**：bahamut / ggameker 仍是 stub；`name_zh` 全部 NULL
- **編輯筆誤共存**：「ハイブリッド体」/「ハイブリット体」、「NODATA」/「NODATE」並存（game8 上游問題）

---

## 程式碼授權 / Code License

`lib/`、`tool/`、`test/` 下的原始碼以 **MIT License** 釋出（見 LICENSE，TODO）。

但本 repo 中：
- `assets/db/digimon.sqlite`（擷取自第三方攻略網站之整理資料）
- `assets/images/digimon/*.webp`（擷取自 game8.jp）
- `.cache/http/` 內任何快取頁面

**不適用 MIT**，著作權屬於各原始來源 / 遊戲原權利人，僅授權於本 app 內非營利展示。請勿單獨抽出再散布。
