# 畢業專題

## 食物拯救計畫

### Backend

食物拯救計畫後端。

#### Getting Started

```bash
npm install

npm start
```

### frontend

食物拯救計畫前端介面

#### 架構

SAVE_FOOD_BATTLE
├── OpenScreen (歡迎視窗)
├── HomePage (首頁)
│ ├── FoodAlert (通知)
│ │ ├── 即將耗盡
│ │ ├── cubit
│ │ │ └── counter_cubit.dart
│ │ └── view
│ ├── Wallet (錢包)
│ └── ToBuyList (購物清單)
├── ScanPage (掃描發票/食材辨識頁)
│ ├── InvoiceInput (發票輸入)
│ ├── FoodScan (食材辨識輸入)
├── StorefoodPage (食材庫存頁)
│ ├── InstantFood (即將過期)
│ ├── AllFood (所有食材)
├── SettingPage (食材庫存頁)

#### 使用工具

- Flutter
  - google_fonts
  - font_awesome_flutter
  - toggle_switch
  - cupertino_icons
  - anim_search_bar
  - get
  - flutter_bloc

#### 注意

可以在 vscode 插件載 "Better Comments"可以看到更多種類的註解。
