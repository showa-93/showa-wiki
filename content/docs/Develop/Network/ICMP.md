---
title: ICMP
type: docs
author: showa
lastmod: 2023-10-09T03:53:20+09:00
waight: 1
---

インターネットワークの管理や通知のためのメッセージを伝送するプロトコル。
ICMPで伝送するメッセージはIPデータグラムのデータ部に置かれる。  
ICMPのエラー通知のICMPメッセージでエラーが起きた場合、ICMPメッセージを生成しない。  
![hoge](https://scrapbox.io/files/60e61739ca54ef001c26a08d.png)  

## メッセージ

- 到達不可
  - 到達不可メッセージが送信元に対して送られる。
- リダイレクト
  - ホストが誤ったルーターにデータグラムを送信した場合、適切な中継先を送信元ホストに通知する。
- 時間超過
  - IPヘッダのTTLが0になり、データグラムが破棄された場合に送信ももとに通知する
- エコー要求と応答
  - pingで使われている応答要求
  - 任意のデータとして大きなデータグラムを送ることでネットワークの負荷試験にも利用できる