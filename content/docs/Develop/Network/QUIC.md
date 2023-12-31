---
title: QUIC
type: docs
author: showa
lastmod: 2023-10-09T04:33:03+09:00
waight: 1
---

キーワードだけ

- Head of Lineブロッキング
- 0-RTT
- Quic Indicator：chrome拡張でquicが利用されているか確認できる
- QUICパケット
  - QUICフレーム、ロングヘッダパケット、ショートヘッダパケット
  - 終点コネクションID
- ハンドシェイク
  - CRYPTフレームに格納
  - ハンドシェイクの最初にClientHello（鍵交換）とSYNを同時におこなう
  - 2回目以降は事前共有鍵(PSK: Pre-Shared Key)を使うことで0RTTを実現する
- ストリーム
  - コネクション内で順番を守って配送されるバイト列
    - １つの要求と応答は１つのストリームとして扱われる
  - １つのコネクションでストリームは複数扱える
- コネクションの終了
  - 一般的な終了
    - CONNECTION_CLOSEフレームを送信
    - 送信側はコネクションのほとんどの状態を消去し、受信側もパケットの送信をやめる
      - 送信側が一定時間待つことで正常に受信されたと判断する
      - 新しいパケットが送信された場合、暗号化されたパケットを再送する
    - エラーで終了する場合
      - QUIC起因ならCONNECTION_CLOSEフレームにコードと理由を含める
      - アプリケーション起因ならフレーム型のフィールドがないCONNECTION_CLOSEフレームが利用される
  - タイムアウト
    - 一定時間パケットを受信しない場合、コネクションを終了できる
    - ハンドシェイクの交渉で決定する
  - リセット
    - サーバーの再起動でコネクションを継続しようとした場合、タイムアウトまで待つ必要がある
    - 任意のパケットから生成するステートレス・リセット・トークンを使ってNEW_CONNECTION_ID フレームを使ってコネクションをリセットする

- フロー制御
  - ストリームのフロー制御
    - 受信者は、ストリームの受信可能累積バイト数をMAX_STREAM_DATAフレームに入れて送信者に伝えます
  - コネクションのフロー制御
    - ネクションの受信可能累積バイト数をMAX_DATAフレームに入れて送信者に伝えます
  - ストリーム数の制御
    - 1つのコネクションに対して作成してよい累積ストリーム数をMAX_STREAMSフレームに入れて送信者に伝えます

- コネクションのマイグレーション
  - TCPと異なり、IP、portが変更されてもコネクションIDを利用することで、コネクションを維持することができる
  - コネクションを維持する機能のことをコネクションのマイグレーションと呼ぶ
  - 制約
    - マイグレーションできるのはハンドシェイクのあと
    - マイグレーションできるのはクライアントだけ
  - クライアントがIPの変化を検知して、乱数を含むPATH_CHALLENGEフレームを送信し、パス検証を開始
  - サーバはパス検証に応答して乱数を含むPATH_RESPONSEフレームをクライアントに返す
  - クライアントからPATH_RESPONSEフレームがサーバに返却された時点でパス検証を完了する
- NATリバインディング
  - クライアントとサーバの間にNATが存在する環境で一定期間パケットのやり取りがない場合、その通信の外向きのポートを削除する。その後に再度パケットのやり取りが発生した場合、NATが新たにポート番号を割り当てる。これをQUICではNATリバインディングと呼ぶ
  - この場合、サーバ側がポートの変更を検知して、PATH_CHALLENGEフレームを送信してパス検証をおこなう

- コネクションID
  - コネクションを識別するための名前で、長さが8から20のバイト列
  - あるコネクションに対するコネクションIDは、クライアントとサーバの両者がそれぞれ独立に名付ける
  - 終点のコネクションIDには、相手が名付けたコネクションIDを指定
  - 始点のコネクションIDには、自分が名付けたコネクションIDを指定
  - あるコネクションに対して、ハンドシェイク時点では一対のコネクションIDが存在するだけですが、その後コネクションIDを増やせる。自分が新たに作成したコネクションIDは、NEW_CONNECTION_IDフレームによって、通信相手に伝えることができる。

- パス検証
  - クライアントのIPアドレスが正当だと判断できるまでのアドレス確認を「コネクション確立時のアドレス検証」と呼ぶ
  - クライアントのIPまたはポートが変わったときのアドレス検証を「パス検証」と呼ぶ
  - パス検証には、PATH_CHALLENGEフレームとPATH_RESPONSEフレームを使います。両者には、8バイトの乱数が格納されます。PATH_CHALLENGEフレームに収められた乱数と同じバイト列がPATH_RESPONSEフレームに格納されて戻って来れば、パス検証が成功です。

- プライバシー
  - TCPではIPやポートがかわったとき、通信を続ける場合、新しくコネクションを作り直していたため、新旧のコネクションが同じ通信だとはわからない
  - QUICでは同じコネクションIDを使い続けた場合、同じ通信であることが明白になるため、変わったことを検知したら別のコネクションIDを使い始める

- ヘッダ保護
  - QUICではTCPのヘッダにあった情報をペイロードにいれて暗号化することで中間装置がパケットを解析できないようにしている
  - QUICのヘッダ保護は、パケット番号に関連したフィールドをパケットごとにかわるマスクでXORをとることで結果の値を置き換えている
  - マスクの生成
    - クライアントからのInitialパケットにある終点コネクションIDからヘッダ保護用の鍵を生成する
    - あるパケットに対して暗号化されたペイロードの一部を切り出してヘッダ保護用の鍵とともにマスクを生成する

- 増幅攻撃
  - quicではハンドシェイクの際に証明書など大きなデータをやりとりするため、攻撃の標的になりうる
  - 攻撃を緩和する規則として
    - クライアントが送るUDPペイロードの大きさは1200バイト以上
      - 0RTTの場合、PADDINGフレームで1200バイトになるように埋める
      - リトライ機構があり、リトライトークンが渡された場合、IPが詐称されていない証拠になるので、パケットのサイズに制限はない
    - クライアントが正当だと判断できるまでは、サーバの遅れるパケットのサイズは受け取ったバイト数の３倍まで

- [TCP Fast Open](https://www.rfc-editor.org/rfc/rfc7413.html)
  - TCPでも0-RTTでできる仕組みがある
  - ２回目以降だと最初のSYNにデータも載せられる
  - しかし、ネットワークの中間装置にパケットの中身をみて落とすような仕組みがあると使えない

## Reference

- [「QUICをゆっくり解説」 | IIJ Engineers Blog](https://eng-blog.iij.ad.jp/page/2?s=QUICをゆっくり解説)
- [RFC 9000 - QUIC: A UDP-Based Multiplexed and Secure Transport 日本語訳](https://tex2e.github.io/rfc-translater/html/rfc9000.html)
