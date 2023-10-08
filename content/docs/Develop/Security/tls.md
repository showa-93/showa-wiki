---
title: TLS
type: docs
author: showa
lastmod: 2023-10-03T02:04:33+09:00
waight: 1
---

Transport Layer Security
Version: TLS1.0（RFC2246）、TLS1.1（RFC4346）、TLS1.2（RFC5246）、TLS1.3（RFC8446）

トランスポート層の通信のためのセキュリティ。

# Recordプロトコル

**メッセージの転送**
別のレイヤからわたされるデータのバッファを転送する。レコードは最大16364バイトのチャンクに分割される。
**暗号化および完全性の検証**
最初の接続のメッセージはネゴシエーションのために保護されない。ハンドシェイク後はレコード層による暗号化および完全性の検証がはじまる。
**圧縮**
2012年にCRIME攻撃に利用された。TLSの圧縮機能は利用されていない。
**拡張性**
Recordプロトコルが担うのはデータ転送と暗号処理のみで、サブプロトコルで機能の追加ができる。
HandShakeプロトコル、Change Cipher Specプロトコル、Application Dataプロトコル、Alertプロトコル

# Handshakeプロトコル

TLSで使うパラメータのネゴシエーションと認証をおこなう。（6~10のメッセージをやりとりする）
Handshakeプロトコルのメッセージのヘッダにメッセージの種類とメッセージの長さをあらわします。
**フルハンドシェイク**
クライアントとサーバーが一度もセッションを確立したことながない場合、TLSセッションを確立するために実行されるプロトコル。ハンドシェイクが完了したFinishedメッセージの送信から暗号化される。そのため、それまでの通信では平文でやりとりされる。
**クライアント認証**
サーバーから許容できるクライアント証明書が提示された場合、クライアントからCertificateメッセージを送ることでクライアント認証をおこないます。サーバー認証のあとにおこなわれます。
**セッションリザンプション**
フルハンドシェイクによるメッセージの往復や証明書の検証など負荷の高い処理によるオーバーヘッドを回避する仕組み。
Session IDという識別子によってセッションを再開を可能にする仕組み。クライアントは以前のセッションを再開させるためにClient HelloメッセージにSession IDを含めて送信することで共有したマスターシークレットから新しい暗号鍵に移行してからFinishedメッセージを送り、暗号通信に移行します。これにより通信が１往復に省略される。
反対にクライアント側が状態をすべて保持するセッションチケット（RFC 5077）を利用する方法もある。
**再ネゴシエーション**

# 鍵交換

![image](*ServerKeyExchange]メッセージと**ClientKyeExchange**メッセージの２つのメッセージが鍵交換の最初のパラメータの送信に使う。サーバーから鍵交換（[* ServerKeyExchange)）をおこなう場合、鍵交換のパラメータの証明を一緒に送ることでクライアントはサーバーの検証を同時におこなえる。

よく利用される鍵交換アルゴリズム
**RSA**
（TLS1.3で鍵交換のアルゴリズムから廃止）クライアントがプリマスターシークレットを生成。サーバーの公開鍵で暗号化して転送して鍵交換をおこなう。ただし、秘密鍵が漏洩すると過去にわたってすべての暗号データが復号化されてしまう。

**DHE_RSA(Ephemeral Diffie-Hellman)**
[PFS(Perfect Forward Security) https://kaworu.jpn.org/security/Perfect_Forward_Secrecy#:~:text=Perfect%20Forward%20Secrecy%20(PFS)と,鍵交換の概念です%E3%80%82]があり、クライアントとサーバー双方で共通鍵を決定する。RSAによる認証を合わせて利用する。処理速度が遅い問題がある。DH鍵交換には６つのDHパラメータを利用する。次回接続時にパラメータは再利用されないため、共有鍵が漏洩しても安全。このパラメータは乱数と一緒にサーバー側の秘密鍵で署名され、クライアントは検証された証明書の公開鍵でサーバーからきたものだと判別してから利用します。
証明書にパラメータを埋め込む方法もあるが、この場合生成される共有鍵が常におなじになるため、PFSがなくなる。

セキュリティの問題点

- 受動攻撃には安全だが、通信路で相手のフリをする能動的攻撃は受けてしまう。認証により守る必要がある。
- （TLS1.2）DHパラメータのネゴシエーションで生成するDHパラメータの強度を選択できないため、うまく受け入れてもらうことを期待するしかない（TLS1.2）
- （TLS1.2）重要性が無視され[強度が不足したDHパラメータ](https://qiita.com/n-i-e/items/fac121aa5b2a3d16a632)が利用されてきた。

**ECDHE_RSA(Ephemeral elliptic curve Diffie-Hellman) or ECDHE_ECCDSA**
楕円曲線暗号に基づく鍵交換アルゴリズム。処理が高速かつPFSがある。TLS1.2ではRSAか[ECDSA](https://www.jipdec.or.jp/project/research/why-e-signature/public-key-cryptography.html#:~:text=ECDSAとは%E3%80%81楕円曲線,な計算になります%E3%80%82)による認証を併せて利用する。

# 暗号化

TLS1.2ではストリーム暗号化方式、ブロック暗号化方式、AEAD(認証付き暗号)を利用できる。TLS1.3ではAEADだけ利用可能になった。暗号化アルゴリズムによって完全性(=改ざんされてないよね？)を検証する。
[暗号スイートとTLS拡張の関係を再整理 - Qiita https://qiita.com/kj1/items/ad98c124cb4fbc9b2cc7]

**AEAD**
暗号化および認証とデータの完全性の検証を提供する暗号方式。データの気密性だけでなくデータの改ざんを検知し、完全性を保証する。AES-GCMやChaCha20-Poly1305は現在主流となっているAEADアルゴリズム。
AEADアルゴリズムは、次の入力を受け取る。

- 鍵：共有された秘密鍵。
- プレーンテキスト：暗号化されるべきデータ。
- 関連データ：暗号化されないが、認証に使用されるデータ。例えば、ヘッダー情報など。
- ノンスまたは初期化ベクター：各暗号化操作に対して一意であるべき乱数。同じ鍵で複数回使用されることはない。
AEADアルゴリズムの出力は、暗号文と認証タグです。暗号文は暗号化されたデータであり、認証タグは送信者の正当性とデータの完全性を確認するために受信者が使用するバリューです。

# 参考

- [プロフェッショナルSSL/TLS – 技術書出版と販売のラムダノート](https://www.lambdanote.com/products/tls)