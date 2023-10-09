---
title: メッセージブローカー
type: docs
author: showa
lastmod: 2023-10-09T14:51:02+09:00
waight: 1
---

## 重複するメッセージの対応

メッセージブローカーは、基本的にAt least oneceを保証している。そのため、２回以上メッセージが飛ばされる可能性がある。

- 冪等なメッセージハンドラ
  - アプリケーションのメッセージの処理が冪等であるように作る
- 重複メッセージを破棄
  - メッセージを処理するときに消費したメッセージIDをテーブルに格納する
  - 消費済みのメッセージを受けたときは登録に失敗するため検知できる

## TODO

[Apache Kafka](http://kafka.apache.org/)、RabitMQとかとか

- <https://qiita.com/sigmalist/items/5a26ab519cbdf1e07af3>
- <https://tutuz-tech.hatenablog.com/entry/2019/03/13/000434>
- [ストリーミング処理を考える - Qiita](https://qiita.com/masanori0001/items/5ea5f69b875a9675efc4)
<https://www.slideshare.net/laclefyoshi/ss-67658888>
