---
title: DNS
type: docs
author: showa
lastmod: 2023-10-08T16:27:38+09:00
waight: 1
---

## 概要

Domain Name System（ドメイン・ネーム・システム）  
インターネット上のドメイン名とIPアドレスの対応付けを階層化と委任におる分散管理しているシステム。  
ドメイン名に対応する形で管理範囲を階層化する。サブドメインのゾーンを委任することで親子関係をつくる。  
委任は、親のネームサーバーで委任先の子のネームサーバーの委任情報を登録することでおこなう。  
ルートのネームサーバーから順にたどることで、ドメイン名のIPアドレスを取得できる仕組み。  
DNSの通信にはTCPとUDPをサポートする必要がある。  

## レジストリ・レジストラモデル

### レジストリ

ドメイン名の登録管理する組織。以下のような機能をもつ。

- レジストリデータベースの運用管理
- ポリシーに基づいた登録規則の策定
- 登録申請の受付
- Whoisサービスの提供
- ネームサーバーの運用

### レジストラ

ドメイン名の登録者からの申請の取り次ぎ。レジストリとことなり、複数のレジストラが存在する。  
登録者とレジストラを取り次ぐ「リセラ」という事業者も存在する。  
TLDによってレジストラの役割も異なるが、おおよそ下記。  

- 登録者からの登録申請の受付
- レジストリデータベースの登録依頼
- Whoisサービスの提供
- 登録者情報の管理

## 構成

### スタブリゾルバー

別称：DNSクライアント  
利用端末で動作（OSに組み込まれている）、フルリゾルバに名前解決を依頼するDNSのクライアント。  
[リゾルバ自前実装してるnetパッケージ](https://golang.org/src/net/lookup.go?s=5361:5417#L159)

### フルリゾルバー

別称：キャッシュDNSサーバー、参照サーバー、DNSサーバー  
名前解決要求をスタブリゾルバーから受け付け、問い合わせを受けたドメイン名がキャッシュされている場合、スタブリゾルバにその結果を応答する。  
存在しない場合、権威サーバーへ問い合わせを行う。問い合わせ結果である委任情報やIPアドレスをキャッシュする。  

- **ヒントファイル**  
ルートの権威サーバーの問い合わせ先はフルリゾルバー自身でもっている  
初回の名前解決の前に読み込まれる。  
- **プライミング**  
最新のルートサーバーの一覧を得る仕組み  
初回の名前解決時にヒントファイルを元にルートサーバーに問い合わせる  

### フォワーダー

スタブリゾルバーとフルリゾルバーの間に配置され、問い合わせと応答を中継する。  

利用メリット

- フルリゾルバー相当の機能を簡易的に実装できる
- ネットワーク内の利用者が使うフルリゾルバーのDNS設定を各端末で変更する必要がなくなる
  - フォワーダーで一括で対応する

### 権威サーバー

別称：権威DNSサーバー、ゾーンサーバー、DNSサーバー  
委任を受けたゾーンの情報と委任しているゾーンの委任情報を保持するネームサーバー。  
フルリゾルバーからの問い合わせを受けて、自分の保持する情報を応答する。  
権威サーバーはゾーンの設定内容を「リソースレコード」という形式で保存している。  

#### 可用性確保のための冗長化

複数台の権威サーバーでフルリゾルバーからのアクセスを分散させる。  
メインの権威サーバーを「プライマリサーバー」、ゾーン転送によりコピーされた権威サーバーを「セカンダリサーバー」と呼ぶ。  

- DNS NOTIFY：プライマリサーバーでゾーンデータが更新された場合、セカンダリサーバーに通知する。
- ゾーン転送方法
  - AXFR（Authoritative Transfer）：ゾーンのすべての情報を送る
  - IXFR（Incremental Transfer）：特定のバージョンからの差分のみを送る  
  ![x](https://scrapbox.io/files/60ba2937300a82002398af20.png)

#### リソースレコード

- リソースレコードセット（RRset）
  - 同じドメイン名、タイプ、クラスでデータが異なる集合
- ゾーンファイル
  - 権威サーバーが読み込むファイル。リソースレコードをまとめたもの
  - code: ゾーンファイル
    - example.jp. IN SOA (
      - ns1.example.jp.         ; MNAME
      - postmaster.example.jp.  ; RNAME
      - 2021013001              ; SERIAL
      - 3600                    ; REFRESH
      - 900                     ; RETRY
      - 604800                  ; EXPIRE
      - 3600                    ; MINIMUM
   )
    - example.jp. IN NS           ns1.example.jp
    - example.jp. IN NS           ns2.example.jp
    - ns1.example.jp IN A         192.0.2.11
    - ns2.example.jp IN A         192.0.2.12

リソースレコード

| 項目 | 説明 |
|:--|:--|
| ドメイン名 | 問い合わせで指定されたドメイン名。同じドメイン名の場合、２行目以降は省略可。 |
| TTL | Time to Live。リソースレコードのキャッシュ時間。 |
| クラス | ネットワークの種類。「IN」 |
| タイプ | 情報の種類。 |
| データ | リソースレコードのデータ |
リソースレコードタイプ

| タイプ | 内容 | 備考 |
|:--|:--|:--|
| A | リソースのデータがIPv4アドレス | 委任情報としてネームサーバーのアドレス情報の登録（グルーコード） |
| AAAA | リソースのデータがIPv6アドレス | 上同 |
| NS | ゾーンの権威サーバーのホスト名 | ゾーン頂点に設定する場合とサブドメインの委任情報 |
| MX | ドメイン名宛の電子メールの配送先と優先度 |  |
| SOA | ゾーンの管理に関する基本的な情報 | Start of Authority |
| CNAME | ドメイン名に対する正式名 | 例えばcdnのドメイン名を指定すると、名前解決をフルリゾルバがおこなう |
| TXT | 任意の文字列 | Sender Policy Frameworkなどなりすまし対策で設定したり |
| PTR | IPアドレスに対するドメイン名 | 逆引き用 |
| DNSKEY | 署名者が署名に使ったそのゾーンの公開鍵 |  |
| RRSIG | 各RRSetに付加される電子署名 |  |
| DS | 公開鍵のハッシュ値 | 親ゾーンに登録 |
| NSEC | 不在証明（存在するリソースレコードの一覧） | NSEC3/NSEC3PARAM |
 ドメイン名

| 絶対ドメイン名 | absolute domain name | TLDまで省略なく表記 |
|:--|:--|:--|
| 相対ドメイン名 | relative domain name | ドメイン名を省略した表記 |
| 完全修飾ドメイン名 | FQDN | TLDまで含むドメイン名。ルートを含まない。 |

## DNSメッセージの形式

DNSメッセージは、DNSの問い合わせと応答に同じ構造が使われる。

フォーマット

```txt
 Headerセクション
  各種制御情報を含むヘッダ部
  規定されたビット長で順番に並ぶ
```

- Questionセクション
  - 問い合わせるドメイン名や情報のタイプ
- Answerセクション
  - 問い合わせしたドメインのリソースレコード
- Authorityセクション
  - ゾーンの委任情報がある
- Additionalセクション
  - 子の権威情報やDNSクッキーがはいってくる

## DNSの動作確認

- dig/drill
  - DNSの通信でやりとりされるDNSメッセージがセクションごとに出力される
  - 名前解決要求のオプション
    - フルリゾルバーに対しては名前解決要求が必要（再帰問い合わせ）
      - `dig domain名`
    - 権威サーバーに対しては名前解決要求を無効にする（非再帰問い合わせ）
      - `dig +norec domain名`
  - タイプを指定して問い合わせる
    - `dig domain名 -t AAAA`

- [IP Anycast - cloudflare](https://www.cloudflare.com/ja-jp/learning/dns/what-is-anycast-dns/)
  - 共通のサービスIPアドレスを複数のホストで共有する仕組み
  - RFC1546
  - [BGP - JPNIC](https://www.nic.ad.jp/ja/newsletter/No35/0800.html)

### セキュリティ

- DNS水責め攻撃
  - [権威DNSサービスへのDDoSとハイパフォーマンスなベンチマーカ / DNS Pseudo random subdomain attack and High performance Benchmarker - Speaker Deck](https://speakerdeck.com/kazeburo/dns-pseudo-random-subdomain-attack-and-high-performance-benchmarker)

## 参考

- [DNSがよく分かる教科書](https://www.amazon.co.jp/dp/B07KQSRZ1S/)