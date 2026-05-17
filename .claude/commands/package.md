---
description: 將 Flutter 專案打包為 Windows release exe，產出可分發資料夾
---

執行以下步驟，將數碼寶貝時空異客資料庫 app 打包成可發佈的 Windows 版本：

1. 確認 `assets/db/digimon.sqlite` 存在；若不存在，請執行 `dart run tool/scrapers/init_db.dart`。
2. 執行 `flutter clean` 與 `flutter pub get`。
3. 跑 `dart run build_runner build`（產生 drift 的 .g.dart）。
4. 跑 `flutter build windows --release`。
5. 把 `build\windows\x64\runner\Release\` 整個目錄複製到 `dist/digimon-guide-vYYYYMMDD/`。
6. 在 `dist/` 中產生 zip：`Compress-Archive -Path dist/digimon-guide-vYYYYMMDD -DestinationPath dist/digimon-guide-vYYYYMMDD.zip`。
7. 在最後告訴使用者：產物路徑、檔案大小，並提醒首次啟動會在 `%APPDATA%\..\Local\com.example.digimon_story_time_stranger` 建立 user data。

打包過程中：
- 若 release build 出錯，**不要** 改用 debug 包裝。請先排查錯誤、再 retry。
- 若 sqlite 檔大小為 0（只有 schema 沒有資料），打包前先請使用者確認是否要先 `/sync`。
