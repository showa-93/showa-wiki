---
title: Web関連
type: docs
author: showa
lastmod: 2023-10-09T04:37:57+09:00
waight: 1
---

セキュリティ関連のメモ

## [CSRF（クロスサイトリクエストフォージェリ）/XSRF](https://www.shadan-kun.com/blog/measure/2640/)

オンラインサービスを利用するユーザーがログイン状態を保持したまま悪意のある第三者の作成したURLなどをクリックした場合などに、本人が意図しない形で情報・リクエストを送信されてしまうことを意味します。
サービス提供者が考えるべき対策の一つに、どこから送られたリクエストなのか。このリクエストはユーザーが送ったものなのかを照合するシステムや、送信元のURLに対する照合、リクエストを送る時のパラメータに対する照合など、必要に合わせて適用し、脆弱性を排除しておくことが求められます。

- [IPA ISEC リクエスト強要（CSRF）対策](https://www.ipa.go.jp/security/awareness/vendor/programmingv2/contents/301.html)

## [CORS(Cross-Origin Resource Sharing)](https://dev.classmethod.jp/cloud/cors-cross-origin-resource-sharing-cross-domain/)

ブラウザがオリジン(HTMLを読み込んだサーバのこと)以外のサーバからデータを取得する仕組みです。各社のブラウザには、クロスドメイン通信を拒否する仕組みが実装されています。れは、クロスサイトスクリプティングを防止するためです。

- [CORS を分かってないから動くコード書いて理解する](https://qiita.com/mochizukikotaro/items/6b72ad595db8a6b5514f)
- [なんとなく CORS がわかる...はもう終わりにする。](https://qiita.com/att55/items/2154a8aad8bf1409db2b)

## JSON Web Token

JSON Web Token(JWT)はHTTP認証ヘッダやURIクエリパラメータなどスペースに制約のある環境を意図したコンパクトな表現形式である。JWTの推奨される発音は, 英単語の"jot"と同じである.

- [JWT draft](https://openid-foundation-japan.github.io/draft-ietf-oauth-json-web-token-11.ja.html)
- [Yahooにおける活用事例](https://techblog.yahoo.co.jp/advent-calendar-2017/jwt/)
- [JSON Web Tokenを理解する](<https://scrapbox.io/fendo181/JWT(JSON[/> Web]Token)%E3%82%92%E7%90%86%E8%A7%A3%E3%81%99%E3%82%8B%E3%80%82)
- [JWTについて簡単にまとめてみた](https://hiyosi.tumblr.com/post/70073770678/jwt%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E7%B0%A1%E5%8D%98%E3%81%AB%E3%81%BE%E3%81%A8%E3%82%81%E3%81%A6%E3%81%BF%E3%81%9F)

## [Please Stop Using Local Storage](https://dev.to/rdegges/please-stop-using-local-storage-1i04)

JWTでは、有効期限を短く設定することをお勧めします。WebSocketを使用している場合は、（たとえば）10分の有効期限でJWTを発行し、ユーザーがまだ接続してログインしている場合は8分ごとに自動的に新しいものを再発行することもできます。その後、ユーザーがログアウトするか切断されたとき。最後に発行されたJWTはわずか10分で無効になります（この時点で攻撃者にとってはまったく役に立たなくなります）。

## OAuth2.0

- [OAuth2.0の実装](https://www.slideshare.net/masatoshitada7/oauth-20spring-security-51-121418814)

## [AES(Advanced Encryption Standard)](https://www.wdic.org/w/WDIC/AES)

共通鍵暗号アルゴリズムである。128ビット、192ビット、256ビットの鍵長が使える。

- [Wiki](<https://ja.wikipedia.org/wiki/Advanced[/> Encryption]Standard)

## [XST(Cross-Site Tracing)](https://blog.tokumaru.org/2013/01/TRACE-method-is-not-so-dangerous-in-fact.html)

Webサーバの HTTP Trace 機能と XSS を組み合わせて、クライアントの情報を盗む。  
HTTP TRACEメソッドはHTTPヘッダも含めてすべての情報をクライアントに表示するデバッグの機能。この機能とXSSを組み合わせて、cookie情報やBASIC認証のパスワードなどを盗む。  

## [Tabnabbing](https://securityblog.jp/words/1061.html)

タブナビング(Tabnabbing)とは、Webブラウザーのタブ表示機能を利用した[フィッシング http://it-words.jp/w/E38395E382A3E38383E382B7E383B3E382B0.html]の一種で、ブラウザーのアクティブでないタブの中身をユーザーが気づかないうちにSNSや銀行などの偽ログインページに書き変えてしまうという攻撃手法。

## ARPスプーフィング

## WPADハイジャック

## DNSハイジャック

## DNSキャッシュポイズニング

## BGP経路ハイジャック
