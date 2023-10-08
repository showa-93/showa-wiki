---
title: Chrome Extension
type: docs
author: showa
lastmod: 2023-10-08T15:03:01+09:00
waight: 1
---

- [Extensions - Chrome for Developers](https://developer.chrome.com/docs/extensions/)

拡張機能は下記コンポーネントで構成されている

- background scripts
- content scripts
- options page
- UI elements

## [Manifest](https://developer.chrome.com/docs/extensions/mv3/intro/mv3-overview/)

Manifest Fileとはその拡張機能に関する情報を書くものであり、json形式で書きます。
具体的にはその拡張機能の名前と説明、使用するスクリプトなどのパス、chrome.APIを用いる為のパーミッションの設定などを書きます。
拡張機能のルートフォルダにmanifest.jsonという名前で配置します。
マニフェストにスクリプトを登録すると、拡張機能に動作が通知される。

manifest.json

```json
 {
   "manifest_version": 2,
   "name": "Input Helper",
   "version": "1.0",
   "description": "Build an Extension!",
   "permissions": ["activeTab", "declarativeContent", "storage"],
   "background": {
  "scripts": ["background.js"],
  "persistent": false
   },
   "page_action": {
  "default_popup": "popup.html",
  "default_icon": {
    "16": "images/user_group.png"
  }
   },
   "options_page": "options.html",
   "icons": {
  "16": "images/alert.png"
   }
 }
```

### フィールド

### manifest_version

マニフェストのバージョン
3が今後主流になるけど、しばらく２だよ

### background

- scripts: [読み込むファイル]
- persistent:
- true
  - バックグラウンドで永続的に動作し続ける
- false
  - 必要に応じて読み込むイベントページ

### page_action

ツールバーの拡張のボタンを押下したときに表示するポップアップを設定できる。

- default_popup: *.html
- default_icon: {iconのpngを指定する(16, 32, 48,128)}
- ツールバー固有のアイコン

### permissions

利用を許可するAPIを指定できる。

### options_page

拡張機能のオプションページを設定できる。

### icon

オプションページのfaviconなどに設定される

## [API](https://developer.chrome.com/docs/extensions/reference/)
