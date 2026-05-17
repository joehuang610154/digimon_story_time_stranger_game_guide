---
description: 從各來源網站重新抓取資料，更新 assets/db/digimon.sqlite
---

執行步驟：

1. 確認 `assets/db/digimon.sqlite` 已存在。若沒有，先跑 `dart run tool/scrapers/init_db.dart` 建立空 schema。
2. 跑 `dart run tool/scrapers/sync.dart $ARGUMENTS`，將 `$ARGUMENTS` 帶入腳本。
   - 沒有額外參數時：執行所有來源、下載圖片。
   - 常用變化：`--no-images`、`--refresh`、`--only=digimons,evolutions`、`--db=path/to.sqlite`。
3. 跑完後：
   - 確認 SQLite 檔最後修改時間有更新。
   - 用 `sqlite3 assets/db/digimon.sqlite "SELECT COUNT(*) FROM digimons; SELECT COUNT(*) FROM evolutions; SELECT COUNT(*) FROM skills;"` 報告各表的列數。
4. 如果有錯誤：
   - HTTP 4xx / 5xx：報告對應的 source 與 URL，**不要** 自動重試或更換來源。
   - HTML 結構變動：報告哪個 selector 失效，請使用者確認新結構，**不要** 自己亂猜。
5. 完成後提醒使用者：app 啟動時若已存在 user data 中的 DB，會優先讀那份；可在「設定」頁面手動清除 user data，或刪除 `%LOCALAPPDATA%\com.example.digimon_story_time_stranger\db\digimon.sqlite`。

注意：sync 不會清空 assets/db/digimon.sqlite，而是 upsert。如果想完全重建，請先 `dart run tool/scrapers/init_db.dart`。
