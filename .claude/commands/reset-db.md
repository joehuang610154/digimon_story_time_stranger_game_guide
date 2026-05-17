---
description: 重建 assets/db/digimon.sqlite（清空所有資料，回到空 schema）
---

僅在使用者明確要求「重建」「清空」「reset」資料庫時執行：

1. 確認使用者是否要備份目前的 `assets/db/digimon.sqlite`。若要，複製到 `assets/db/digimon.backup-YYYYMMDD-HHMM.sqlite`。
2. 跑 `dart run tool/scrapers/init_db.dart`。
3. 提示使用者：必要時跑 `/sync` 重新抓取資料。
4. 也建議刪除使用者裝置上的舊 DB：`Remove-Item "$env:LOCALAPPDATA\com.example.digimon_story_time_stranger\db\digimon.sqlite"`。
