---
title: ハッシュ関数
type: docs
weight: 1
lastmod: 2023-10-03T01:17:42+09:00
---

任意長のメッセージに対して、メッセージを代表する固定長の値を出力する関数。ハッシュ関数の出力する固定長の値をハッシュ値と呼ぶ。  
同じハッシュ関数に同じメッセージが入力された場合、同じハッシュ値が出力されなければならない。さらに入力のメッセージのサイズに問わず高速に計算できることが求められます。  

## 完全ハッシュ関数

- [Perfect Hashing](http://burtleburtle.net/bob/hash/perfect.html)
- [perfect hash functionの概要 - Blog::Broomie.net](http://blog.broomie.net/perfect-hash-function%E5%AE%8C%E5%85%A8%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E9%96%A2%E6%95%B0%E3%81%AE%E6%A6%82%E8%A6%81/)

ハッシュ関数が単射(→必ず唯一の値に射影される)で**正しい入力に対して必ず異なるハッシュ値が一意に定まる**場合のハッシュ関数を完全と呼ぶ。１つのハッシュテーブルで目的のデータを直接探すことができる。入力の範囲がわかっており変化しない場合に成立する。  
n個のキーに対してn個の連続する整数がハッシュの値域となる場合、最小完全ハッシュ関数と呼ぶ。参照の単純化と無駄なデータ領域が発生しないのでコンパクトになる。  
完全ハッシュ関数が有効なケースは

- 更新が無い莫大なkey、valueのデータセット
- keyの探索(lookup)が高頻度

## 安全性

暗号学的ハッシュ関数の安全性は以下の３種類の性質で議論される。  

- **原像計算困難性（一方向性）**  
与えられたハッシュ値の元のメッセージを求めることが困難である性質。逆計算が困難な関数を一方向性関数と呼ぶ。  
この一方向性を破ろうとする攻撃のことを原像攻撃と呼ぶ。同じハッシュ値が得られるメッセージを出力することが目的の攻撃です。  

- **第２原像計算困難性**  
メッセージ（第１原像）とそのハッシュ値を与えられたとき、同じハッシュ値を出力するメッセージ（第２原像）を求めることが困難である性質。  

- **衝突困難性**  
同じハッシュ値になるような２つのメッセージを求めることが困難である性質。  
ハッシュ関数が出力するハッシュ値は、入力のメッセージより要素数が小さくなるため、同じハッシュ値をもつメッセージが存在する。  
この同じハッシュ値が出力される現象をハッシュ値の衝突と呼ぶ。また、衝突した２つのメッセージを衝突ペアと呼ぶ。  

### 安全性の強弱

第２原像計算困難性を破ることと衝突困難性を破ることを比較した場合、衝突困難性を破る方が実現しやすい。特定のハッシュ値の衝突より任意のハッシュ値の衝突のほうが条件がゆるいため。  
攻撃が容易な性質を防ぐ方が安全性が強いため、衝突困難性のほうが安全性が高い。  
衝突困難性を持つならば、異なる２つのメッセージが同じハッシュ値を持つことが困難であるため、ハッシュ値から元のメッセージの復元が困難である。  
よって、衝突困難性を持つならば原像計算困難性をもつため、衝突困難性のほうが安全性が強いと言える。  

### 安全性評価

アルゴリズムの安全性を表す指標としてセキュリティビットが用いられる。あるアルゴリズムに対して必要な攻撃の計算量が$2^n$のとき、そのアルゴリズムの安全性はnビットセキュリティという。  
前述の安全性に対する総当り攻撃による計算量は次の表のようになる。  

| 安全性の種類 | 計算量 | ビットセキュリティ |
| :- | :-: | :-: |
| 原像計算困難性（一方向性） | $2^{n-1}$ | $n$ |
| 第２原像計算困難性 | $2^{n-1}$ | $n$ |
| 衝突困難性 | $2^{n/2}$ | $n/2$ |

### その他の安全性

- **近似衝突困難性**  
よく似たハッシュ値をもつ２つの異なるメッセージを特定が困難である性質。  
- **部分原像計算困難性**  
一部が不明なメッセージとそのハッシュ値から不明な一部を特定することが困難である性質。  

## ハッシュ関数の構成

### 反復型ハッシュ関数

- Miyaguchi-Preneel構造
- Merkle-Damgård構造
- Davies-Meyer構造

### Sponge構造

## 攻撃

### 誕生日攻撃

バースデーパラドックスを利用した攻撃。  

バースデーパラドックスとは、「何人集まれば誕生日の一致するペアが存在するか」という問題（誕生日問題）を考えたときの直感の確率と数学的事実の乖離についてのパラドックです。  
n個の箱にq個のボールを入れるとき$q=\sqrt{n}$のときに同じ箱に２個以上入る確率は0.3以上であることが知られている。特に$q=1.18\sqrt{n}$のときの確率は0.5以上となる。  
これを誕生日問題についてあてはめると20人$(\sqrt{365})$で0.3という確率で一致するペアが存在する。また、24人$(1.18\sqrt{365})$集まれば$1/2$の確率になる。  

前述の内容をハッシュ関数の世界で考えると、ハッシュ値がkビットとすると$2^k$通りの箱が存在する。  
先程の数学的事実より$q=\sqrt{2^k}=2^{k/2}$回計算すると0.3以上の確率で衝突ペアが求まる。  

### 伸長攻撃（Length Extension Attack）

- [Length Extension Attackの原理と実装 - CTFするぞ](https://ptr-yudai.hatenablog.com/entry/2018/08/28/205129)
- [ハッシュ関数の伸長攻撃 - BsBsこうしょう](https://a8pfactory.hatenablog.com/entry/2021/02/06/150536)

$H$をMD5やSHA1などの反復型ハッシュ関数としたときに、$H(m_1)$から$H(m_1||m_2)$を求める攻撃のことを伸長攻撃と呼ぶ。  
既知のハッシュ値とメッセージから未知のSALTを先頭に結合されたメッセージのハッシュ値でも攻撃者が任意のメッセージを付与した新しいハッシュ値を計算することができる。  

反復型ハッシュ関数では入力のメッセージをブロックに分けてブロックごとに処理をする。メッセージのビット数がブロックのサイズの倍数でない場合、メッセージの最後にパディングが付け足される。  
最初のブロックで初期ベクトルⅣを与えブロックを処理する。計算した結果を順番に並べた結果がハッシュ値となるがブロック数が多い場合、前回計算したハッシュ値を初期ベクトルⅣとして同様の処理をする。  
つまり、一つ前のブロックのハッシュ値がわかればメッセージを追加したハッシュ値を計算することが可能であることがわかる。  

伸長攻撃では次のような攻撃に利用できる。（By ChatGPT4）

- **データ改ざん**：既知のハッシュ値とメッセージに追加のデータを付加して、新しいハッシュ値を計算することができる。
- **メッセージの偽装**：新しいハッシュ値を使用して偽のメッセージを送信することができる。
- **認証の回避**；新しいハッシュ値を使用して認証を回避することができます。
- **署名の偽造**: 新しいハッシュ値を使用してデジタル署名を偽造することができる。

### HashDoS攻撃

- [Effective DoS attacks against Web Application Plattforms – #hashDoS [UPDATE3] | Cryptanalysis – breaking news](https://cryptanalysis.eu/blog/2011/12/28/effective-dos-attacks-against-web-application-plattforms-hashdos/)
- [Webアプリケーションに対する広範なDoS攻撃手法(hashdos)の影響と対策 | 徳丸浩の日記](https://blog.tokumaru.org/2011/12/webdoshashdos.html)

ハッシュテーブルの脆弱性を利用したWebアプリケーションのCPU資源を枯渇させるサービス妨害攻撃。  
ハッシュテーブルのハッシュ値が衝突するような多くの異なるキーがテーブルにマップされているとハッシュテーブルに対するあらゆる操作の計算量が単純なリンクトリストの操作まで落ちる。  
これを利用してHTTPのリクエストの処理にハッシュテーブルを利用しているようなサーバーに対して、ハッシュ値がおなじになるキーを大量にリクエストのパラメータに含ませることでⅠ回のPOSTリクエストでCPUを枯渇させます。  

## 暗号学的ハッシュ関数

### MD5

### SHA1

### SHA2

### SHA3

### Whirlpool

## 非暗号化ハッシュ

### Division Method

### Multiplication Method

### Universal Hashing

### Lookup3

### MurmurHash

- [MurmurHash - Wikipedia](https://en.wikipedia.org/wiki/MurmurHash)
- [aappleby/smhasher: Automatically exported from code.google.com/p/smhasher](https://github.com/aappleby/smhasher)
  - 著者のmurmurhashの実装
- [MurmurHash - nojima](https://scrapbox.io/nojima/MurmurHash)
- [twmb/murmur3: Fast, fully fledged murmur3 in Go.](https://github.com/twmb/murmur3)

ハッシュベースの検索向けのハッシュ関数である。2008年にAustin Applebyによって作成された。名前は内部ループで使用される2つの基本演算、乗算（MU）と回転（R）に由来する。  

最新のバージョンは`MurmurHash3`である。32bitまたは128bitのハッシュ値を生成する。128bitの場合、プラットフォームごとに最適化されているためx86とx64では同じ値が得られない。`MurmurHash2`は32bitまたは64bitのハッシュ値を生成する。多くのバリエーションがあり、オリジナルの修正版のMurmurHash2Aやインクリメンタルに動作するCMurmurHash2A、x64に最適化されたMurmurHash64Aなどがある。`MurmurHash1`は`Lookup3`より高速な関数を作る試みとして作られた。`MurmurHash1`では`Lookup3`のように64bitのハッシュ値を生成できなかった。  

`MurmurHash`は衝突攻撃に脆弱な可能性がある。ランダムなシート値をつかった実装でもHashDoS攻撃に対して脆弱であることが示されている。  

MurmurHash3の実装は、以下のステップで構成されています。[Goによる実装](https://gist.github.com/showa-93/1ff2c1488c358bb2b924720696116dc2/#file-hash-murmur3-go)

1. 初期化: ハッシュ関数は、初期ハッシュ値としてシード値を受け取ります。このシード値は、異なるハッシュ値を生成するために変更することができます。
2. ブロック処理: 入力データは、固定サイズのブロックに分割されます。各ブロックは、ハッシュ関数によって個別に処理されます。ブロックのサイズは、x86アーキテクチャでは4バイト、x64アーキテクチャでは16バイトです。
3. ミキシング: 各ブロックは、ビットシフト、ビットXOR、乗算などの操作を使用してミキシングされます。これにより、ハッシュ値の分布が均一になります。
4. 結合: ミキシングされたブロックは、初期ハッシュ値と結合されます。これによりハッシュ値が生成されます。
5. 最終処理: 最後のブロックが処理された後、ハッシュ値は最終処理ステップを経て、最終的なハッシュ値が生成されます。

### CityHash

### FNV (Fowler-Noll-Vo) Hash

### Jenkins Hash Function

## 参考

- [ハッシュ関数 - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E9%96%A2%E6%95%B0)
- [暗号学的ハッシュ関数 - 安全神話の崩壊と新たなる挑戦](https://www.jstage.jst.go.jp/article/essfr/4/1/4_1_57/_pdf)
- [ハッシュ関数の安全性に関する技術調査報告書](https://www.cryptrec.go.jp/exreport/cryptrec-ex-0213-2004.pdf)
- [4章 ハッシュ関数 - 電子情報通信学会知識ベース](https://www.ieice-hbkb.org/files/01/01gun_03hen_04.pdf)
- [高速ハッシュアルゴリズム – YOSBITS](http://www.yosbits.com/wordpress/?p=1442)
- [Indeed MPH:高速で小さいイミュータブルなキー・バリューストア - Indeed エンジニアリング・ブログ](https://jp.engineering.indeedblog.com/blog/2018/02/indeed-mph%E9%AB%98%E9%80%9F%E3%81%A7%E5%B0%8F%E3%81%95%E3%81%84%E3%82%A4%E3%83%9F%E3%83%A5%E3%83%BC%E3%82%BF%E3%83%96%E3%83%AB%E3%81%AA%E3%82%AD%E3%83%BC%E3%83%BB%E3%83%90%E3%83%AA%E3%83%A5%E3%83%BC/)  
- [暗号の安全性評価 - NICT NEWS](https://www.nict.go.jp/publication/NICT-News/1303/01.html)
- [hash/maphashコードリーディング - Qiita](https://qiita.com/shibukawa/items/d483889731c34d3e5faa)
