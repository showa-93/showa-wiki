---
title: tmp
type: docs
author: showa
lastmod: 2023-10-03T02:03:23+09:00
waight: 1
---

ScrapBoxから移行中

アルゴリズム

# アルゴリズム

# 整数論

- mod
  - 割ったあまりをもとめるやつ
  - [「1000000007 で割ったあまり」の求め方を総特集！ 〜 逆元から離散対数まで 〜 - Qiita https://qiita.com/drken/items/3b4fdf0a78e7a138cd9a]
- [素数判定](https://go.dev/play/p/FRPZCH1szQN)
  - [エラトステネスの篩](https://go.dev/play/p/pMTS1BIBeVF)
    - 与えられた範囲内のすべての素数を列挙するアルゴリズム
    - 計算量：O(N log log N)
- 最大公約数
  - [ユークリッドの互除法](https://go.dev/play/p/xOFXEUkMl82)
    - x>=yのときgcd(x,y)とgcd(y,xをyで割ったあまり)は等しい
    - 計算量：O(log y)
    - [拡張ユークリッドの互除法 〜 一次不定方程式 ax + by = c の解き方 〜 - Qiita https://qiita.com/drken/items/b97ff231e43bce50199a]
    - [ラメの定理]
      - >a, b を非負整数とし、小さい方の数を十進法で表したときの桁数を d とする。このとき、ユークリッドの互除法を用いて a と b の最大公約数を求めるときの計算回数は、5d 回以下となる。
    - [拡張ユークリッドの互除法](https://go.dev/play/p/m3SpUNTO3Z_I)
      - ax + by = gcd(a, b)を満たすx, yを求める
- ![image](べき乗 <https://go.dev/play/p/H8EQVbXNwms>)
  - (x^n/2)^2とすることで半分の計算量で済む
- ![image](Prime Factorize)
  - 整数nを素因数分解する
- [最小公倍数(Least common multiple)]
- ![image](Euler's phi function)
- ![image](Extended Euclid Algorithm)
- [離散対数問題](https://tex2e.github.io/blog/crypto/DLP)
  - [Baby-step Giant-step https://go.dev/play/p/BOaKgCmTOpT]
    - [Baby-step Giant-stepアルゴリズムを解釈する https://sono-portal.firebaseapp.com/techblog/EZlVBfa4NkgR8T2na53l]
    - ![image](https://scrapbox.io/files/633b5a9e361bfe001db4618f.png)
- ニム
  - 石の山を取り合うゲーム。排他的論理和による必勝法がある
  - [ニム（複数山の石取りゲーム）の必勝法 | 高校数学の美しい物語 https://manabitimes.jp/math/950]
- グランディ数
  - [不偏ゲームのグランディ数 (ニム数) https://cympfh.cc/aiura/game-nim#:~:text=グランディ数とは不偏,値のことを言う.&text=ここで%20mex,数のことである.]

# 数列/集合

- [尺取法]
  - <https://go.dev/play/p/ZgzoAyFCbzI>
  - <https://go.dev/play/p/rWReZCQPm6z>
  - 連続する区間の値や数などを求める問題で利用できる
  - 前計算をおこない、前計算した範囲の差分で区間を表現することで求める
  - ![image](しゃくとり法 (尺取り法) の解説と、それを用いる問題のまとめ - Qiita <https://qiita.com/drken/items/ecd1a472d3a0e7db8dce>)
- [反転]
  - 反転操作に対する問題
  - ある範囲で反転したかどうかを0, 1でもつことで、各マスに対して反転結果をもつことなくある位置がどっちを向いているか判定できる
  - Face The Right Way POJ No.3276
    - <https://go.dev/play/p/7vEh_Wium_s>
  - Fliptile POJ No.3279
    - 最初の行を確定すると次の行以降も確定するので順番に試す
    - <https://go.dev/play/p/ot3pHv5pVro>

# ソート

- ![image](挿入ソート <https://go.dev/play/p/27ZG-NkZNte>)
  - 1個ずつ全部と順番にくらべていくやつ
  - [シェルソート](https://go.dev/play/p/_pNxVBZ13qD)
    - 一定の間隔で先に大雑把に並び替えて、ある程度整列した状態をつくることで
    - ソートの効率をあげたソート
    - O(N^1.25)くらいまで性能がでると予測されてる
- ![image](バブルソート <https://go.dev/play/p/hj4SYpxFoOi>)
  - 端っこから隣同士をくらべるやつ
- ![image](選択ソート <https://go.dev/play/p/hrsihLuVKwf>)
  - 配列の最小の要素を探して順番に先頭と交換していくあれ
- [安定ソートとは](https://go.dev/play/p/ZxTsQ-ojTXu)
  - 比較する値に同じ値があった場合、入力と同じ順序で出力されるソート
  - バブルソートは安定ソートだが、選択ソートはちがう
- [トポロジカルソート](https://go.dev/play/p/nVbOt9CrHgA)
  - [参考](https://algo-logic.info/topological-sort/#toc_id_2_1)
  - 閉路のない有向グラフを仕事の手順をあらわすデータ構造として利用した場合に、着手すべき順番に列挙するときにおこなうソート

# 探索

- 線形探索
  - O(n)
  - 番兵：検索したい対象を配列に配置することで条件を簡略化して定数倍の高速化をおこなえる
- 二分探索
  - [$ O(log2n)]
- 全探索
  - [半分全列挙]
    - N/2 ずつの 2 グループに分けて全列挙し、2グループ同士を組み合わせる際に高速化する
      - 半分のグループ A を全列挙
      - もう半分のグループ B を全列挙
      - Aの全ての要素について以下を行う
        - A から選ぶ要素を1つに固定したとき、条件に合う要素をBから高速に探す
    - [半分全列挙による全探索の高速化 | アルゴリズムロジック https://algo-logic.info/split-and-list/]
- ハッシュ法
  - O(1)※衝突がなければ
  - ハッシュテーブルを用いた検索
  - ハッシュ関数でキーを生成して一意に求める
- ヒュースティック探索
  - ![image](8クイーン問題 <https://go.dev/play/p/OFZpirNhGjn>)
    - チェス盤に８つのクイーンをお互いに襲撃できないようなおき方を解く問題
    - バックトラックをつかってとくよん
  - [8パズル](https://go.dev/play/p/zmWPJJ1Eqf0)
    - 幅優先探索や深さ優先探索で愚直に計算できる大きさ
    - パズルの状態を記憶して、解法になるパターンを順番に見つけていく
    - サンプルの実装は幅優先探索で実装
  - 15パズル
    - [反復深化（Iterative Deepening）]
      - [IDA*（反復深化A*）](https://go.dev/play/p/fPMh-zt3PS-)
        - 推定値（＝ヒュースティック）を用いて枝を刈り取るアルゴリズム
        - リンクは15パネルを反復深化で解いた
        - 解法との距離をマンハッタン距離で推定値をだして、推定値と実際の値がゼロになるまで深さ優先探索を繰り返す
        - [A*]
          - 反復深化A*に用いた推定値を優先度付きキューを用いたダイクストラをベースとした探索アルゴリズム
          - 「始点から現在地までのコスト＋現在地からゴールまでの推定値」が最も小さい状態から優先的に状態遷移することで速度があがる

# 分割統治

- 分割統治法（Divide and Conquer）
  - ２つ以上の小さい問題に分割してもとの問題の解を求める
  - [全探索](https://go.dev/play/p/Q1-ITDtbUP0)
  - [コッホ曲線](https://go.dev/play/p/5hH8DzC4e-P)
    - 出力結果をスプレッドシートとかでグラフをつくるとみれる
    - ![image](2次元回転行列使うのが正解 <https://go.dev/play/p/LFoDxb0KSJf>)
    - n=5
    - ![image](https://scrapbox.io/files/62ec0ecb32ef7e001f9cd6c5.png)

# 高等的整列

- [マージソート](https://go.dev/play/p/NaqlgKN3i2G)
  - [$ O(nlog2n)]
  - 配列のマージを行うことでソートをおこなう
  - 対象の配列以外で一次保存のためのメモリが必要
  - ai > aj and i < j である組の個数を反転数と呼ぶ
- [パーティション](https://go.dev/play/p/nCyMojPDhp3)
  - O(n)
  - ある基準より大きいか小さいかを分類するアルゴリズム
- [クイックソート](https://go.dev/play/p/IIhImhbqN90)
  - 平均=O(nlog2n)
  - どんなデータに対しても一定のソートをおこなうのでソート済みのデータなどではO(n^2)
    - 基準をランダムに選ぶなどで工夫する必要がある
  - パーティションを使って離れた要素の交換をおこなうため、安定ソートではない
  - マージソートと異なり追加メモリが必要ではない
- [計数ソート](https://go.dev/play/p/aFoz7ha-BPK)
  - O(n + k)
  - 各要素がk以下の数列に対してソートをおこなう
  - ソート時に後ろから取得することで安定ソートになる
  - 対象の配列以外で一次保存のためのメモリが必要

# 動的計画法

- 計算結果をメモリに保持することで効率化をおこなう
  - [フィボナッチ](https://go.dev/play/p/ZeuhDKhH02q)
  - 漸化式でiとi+1しか存在しない場合、偶数と奇数のそれぞれの場合の２つの配列だけでDPテーブルの再利用が可能になるケースがある
- ![image](最長共通部分列（LCS） <https://go.dev/play/p/vo0f3weQOMs>)
  - 二つの列の最長の共通部分列を求める
  - 部分問題に分割して漸化式として解くことができる
- [連鎖行列積](https://go.dev/play/p/jFZDRJAmBcK)
  - 行列の積の計算順序を変えられるため、最小の計算回数になるような順序を求めるアルゴリズム
  - 最小限の組み合わせから順番にコストを求めて、最小になるようなコストを求める
  - わかったようなわかってないような感じ
- [コイン問題](https://go.dev/play/p/12Pf4P-nCqk)
  - j円を支払う時の最小枚数を記録していく
- ナップサック問題
  - [個数制限付きナップサック問題](https://go.dev/play/p/5NbqiNf8LV1)
    - [DPテーブルを１次元に圧縮](https://go.dev/play/p/MnZfJw6vs4J)
    - 価値と重さが決まっている複数の品物を容量が一定のナップサックに詰め込むとき、ナップサックに詰め込める品物の価値の和の最大値は何であるか？
    - 解法パターンにはメモ化再帰を使う場合と漸化式の場合がある
    - [参考](https://dai1741.github.io/maximum-algo-2012/docs/dynamic-programming/)
  - [個数制限付き部分和ナップサック問題](https://go.dev/play/p/PC7Xw0JVF08)
    - 個数に着目して、品物を順番に配置したとき、計算したい値に残りの個数（0以上）が記録されていたかで計算できる
  - [個数制限なしナップサック問題](https://go.dev/play/p/RQQ3wEtOBrO)
    - [DPテーブルを１次元に圧縮](https://go.dev/play/p/EyEbT0nSz5z)
      - １次元に圧縮すると個数制限あり、なしの違いはループの方向だけ
    - i番目の品物を重さをこえない範囲でk個選んで最大の価値にする
    - k個選ぶ＝dpテーブルにおいてi番目の品物を選ぶときにi番目の重さを差し引いた残りの重さで最大の価値に加算することで表現できる
      - i番目で重さ２、価値３の場合
      - j（重さ）=4のとき、i番目の重さを差し引いたj=2のときの最大の価値が３の場合、i番目の価値をたした場合、価値が６になる
- ![image](分割数 <https://go.dev/play/p/lMtaGqZo1Oj>)
  - [数え上げ問題の典型的な考え方](https://algo-logic.info/the_twelvefold_way/)
  - [分割数 - inamori’s diary https://inamori.hateblo.jp/entry/20121216/p1]
    - 基本の証明～[オイラーの五角数定理]で高速化までやってる。詳しい
  - [重複のある場合の組み合わせ]
    - [動的計画法における重複組み合わせの式変形について - ツバサの備忘録 https://emtubasa.hateblo.jp/entry/2018/08/29/161456]
- [最長増加部分列（LIS）](https://go.dev/play/p/LsKXmp50ay9)
  - ２分探索をつかってDPで記録した値を更新していく
  - [参考](https://tutuz.hateblo.jp/entry/2018/06/18/214827)
- [最大正方形](https://go.dev/play/p/IKjJljukxFX)
  - 最大の正方形を調べる問題
  - 動的計画法で書くマスごとに足し上げていく
    - 計算量：[$ O(HW)≒O(n^2)]
- [最大長方形](https://go.dev/play/p/W1HUkRafLhH)
  - 最大の長方形を調べる問題
  - 列方向の前処理をおこなったDPテーブルを用意して、スタックを使って各行の最大面積を求めていく
  - 計算量：O(HW)≒O(n^2)
- ![image](Levenshtein Distance)
- ![image](Traveling Salesman Problem)
  - 巡回セールスマン問題
    - [ビットDP(bit DP)の考え方 ~集合に対する動的計画法~ | アルゴリズムロジック https://algo-logic.info/bit-dp/]
    - [ABC274 E問題]でbitdpを使った類似問題が出題された
- ![image](Chinese Postman Problem)

# データ構造

# 木

- 節点（node）と節点同士を結ぶ辺（edge）で表されるデータ構造
- ある節点と辺がつながっており、浅い節点を親（parent）
  - 同じ親をもつ節点同士を兄弟（sibling）
- ある節点と辺がつながっており、深い節点を子（child）
  - 節点の子の数を次数（degree）
  - 子を持たない節点を外部節点（external node）または葉（leaf）
  - 葉でない節点を内部節点（internal node）
- 根（root）と呼ばれる頂点をあらわす節点を持つ木を[根つき木（rooted tree） https://go.dev/play/p/AA5dlyDHdD8]
  - 根から節点までの長さを深さ（depth）
  - 節点から葉までの最大値を高さ（height）
- [木の直径](https://go.dev/play/p/0ezLw_isoYZ)
  - 木の節点の中で一番遠い節点間の距離のこと
  - [参考](https://37zigen.com/diameter-center-tree/)

- **二分木**
  - すべての節点の子の数が２以下の木
  - ![image](木の巡回 <https://go.dev/play/p/0MRkF9Sy5oj>)
    - 木が深いと再帰が深くなるので注意
  - [木の復元](https://go.dev/play/p/5EkOjCEgrK0)
    - 先行順巡回で根から順番にたどり、中間順巡回で部分木を抽出し、葉から順番にノードを再構築する
  - **二分探索木**
    - 二分探索木条件（binary search tree property）
      - ある節点xの左分木の節点yは x < y を満たす
      - ある節点xの右分木の節点zは z < x を満たす
    - [挿入](https://go.dev/play/p/8RHRhjd4jPc)
      - 偏りがなければO(logn)。高さが高くなるとO(n)になる
      - [平衡二分探索木](https://ja.wikipedia.org/wiki/平衡二分探索木#:~:text=平衡二分探索木%EF%BC%88へ,もの%EF%BC%88平衡木%EF%BC%89である%E3%80%82)
    - [探索](https://go.dev/play/p/oau_5YrC9MJ)
      - O(h) h=木の高さ
    - [削除](https://go.dev/play/p/fPod0tO00jk)
      - O(h) h=木の高さ
    - [回転]
      - 平衡二分木
  - **[二分ヒープ**(https://go.dev/play/p/4i1fgeL_QjD])
    - １つの配列の各要素に対応した完全二分木であらわされたデータ構造
    - max-ヒープ：節点のキーがその親のキー以下である
    - min-ヒープ：節点のキーがその親のキー以上である
    - 優先度付きキュー
      - 挿入、削除：O(logn)

- **全域木**
  - グラフのすべての頂点を含む部分グラフで、木（閉路を持たないグラフ）である限りできるだけ多くの辺をもつ木
  - グラフは複数の全域木をもつ
  - 最小全域木（MST）：全域木の中で辺の重みが最小のもの
    - [プリムのアルゴリズム](https://go.dev/play/p/5cImdbS_Zq2)
      - ![image](参考1](<https://inzkyk.xyz/algorithms/minimum_spanning_trees/jarkins_prims_algorithm/>) [参考2 http://www.dais.is.tohoku.ac.jp/~shioura/teaching/ad09/ad09-10.pdf)
      - 最小探索木を求めるアルゴリズムの１つ
      - [二分ヒープ（優先度付きキュー）で実装](https://go.dev/play/p/kQEswLxq_A5)
        - こっちのほうが効率が良い
        - フィボナッチヒープのほうがInsertがO(1)でできるため、より高速
    - [クラスカル法](https://go.dev/play/p/Q-IW7SU_UyV)
      - [参考](https://37zigen.com/minimum-spanning-tree-kruskal/)
      - Union Find Treeを使って閉路ができないような木をつくる
      - [基本的にこっちのほうが早い](https://yottagin.com/?p=9495#:~:text=and%20vice%20versa)%3F-,基本的にはクラスカル法が良いようです%E3%80%82,-クラスカル法)
        - 辺の重みによるソートの計算次第
  - 最小全域有向木 （Minimum-Cost Arborescence）
    - 重み付き有向グラフで指定された頂点を根とする最小有向木を求める
    - [Edmondsのアルゴリズム]
  - [シュタイナー木問題]
    - 与えられたすべての点を通る最小全域木を求めるのに対して、与えられた部分集合をつなぐ木を求める
  - 最短経路問題
    - 単一始点最短経路
      - 与えられた１つの頂点からすべての頂点への最短経路を求める問題
      - [ダイクストラ](https://go.dev/play/p/HXFPJPoFXxw)
        - 最短経路を探しながらコストの計算をおこなう
        - 親の頂点のコストと辺のコストを加算しながら距離を計算する
        - 負の辺が存在する場合計算ができない
      - [ベルマンフォード](https://go.dev/play/p/h1wqBLTj4W3)
        - 負の重みが存在する場合の単一始点最短経路
        - [ベルマンフォード法による単一始点最短経路を求めるアルゴリズム | アルゴリズムロジック https://algo-logic.info/bellman-ford/]
    - 全点対間最短経路（All Pairs Shortest Path:APSP）
      - すべての頂点のペア間の最短経路を求める問題
      - 優先度付きキューをつかったダイクストラでO(|V|(|E|+|V|)log{V}))
      - [ワーシャルフロイド](https://go.dev/play/p/nOW3vJ5gLVu)
        - 全ての頂点間の最短距離を調べて経路の検出をおこなう
        - ダイクストラとことなり負の辺が存在しても計算可能
        - O(|V^3|)なので実用には向かない
        - [参考](https://yttm-work.jp/algorithm/algorithm_0014.html)
  - ![image](Level Ancestor Problem)
    - 頂点u の祖先であって深さが d であるものを求める問題
      - クエリが事前にわかってるならDFSで探索しながらキューの中身からとれる
    - [Jump Pointer Algorithm（ダンブリング） https://go.dev/play/p/mAe1EIOo34G]
      - ちゃんと実装できてないで
    - [Level Ancestor Problem – 37zigenのHP https://37zigen.com/level-ancestor-problem/]

# ![image](グラフ <https://ocw.hokudai.ac.jp/wp-content/uploads/2016/01/GraphTheory-2007-Note-all.pdf>)

- 対象の集合とそれらのつながりを表す集合
  - [連結成分](https://go.dev/play/p/H1qfax0gwv9)
    - 連結グラフ：グラフに含まれるすべての頂点がいずれかの頂点とリンクしているグラフ
    - [連結成分とは「部分グラフのうち、極大で連結なもの」](https://www.momoyama-usagi.com/entry/math-risan09#i-4:~:text=グラフとなります%E3%80%82-,非連結グラフを連結成分からなるグループで分離,-非連結グラフ)
      - グラフが連結でないとき、その中のうち連結な部分グラフを連結成分と呼ぶ
  - [強連結成分（strongly  connected component）]
    - 有向グラフにおいて、すべての頂点対u, vについて互いに到達可能な連結成分
    - [参考](https://inzkyk.xyz/algorithms/depth_first_search/strong_connectivity/)
- 対象を頂点（Vertex）、つながりを辺（edge）であらわす
- G = (V, E)
  - 頂点の数：|V|
  - 辺の数：|E|
  - 辺：e = (u, v)
  - 辺の重み：w(u, v)
- 頂点uとvの間に辺(u, v)が存在するとき隣接（adjacent）している
- 隣接している頂点の列をパス（path）という
  - 始点と終点が同じパスを閉路（cycle）
- ![image](間接点（Articulation Point） <https://go.dev/play/p/kqb_cLGbmAs>)
  - ![image](取り除くと連結成分が増える頂点（グラフ全体が非連結になる） <http://hos.ac/slides/20110504_graph.pdf>)
  - グラフが連結できなくなる辺を[橋（Bridge）]とよぶ
  - [参考](https://kagamiz.hatenablog.com/entry/2013/10/05/005213)
- フローネットワーク
  - 辺に容量が設定されている有向グラフ
  - [最大フロー問題（Maximum Flow）]
    - 始点から終点へ流れる最大の流量を求める
    - [Ford-Fulkerson法]
      - 実装例はこれ[atcoder/main.go at main · showa-93/atcoder https://github.com/showa-93/atcoder/blob/main/contests/atcoder/tessoku_book/bp/main.go]
- マッチング
  - どの各点も２辺以上つながっていない部分グラフ
  - [参考](https://www.momoyama-usagi.com/entry/math-risan17)
- グラフの実装
  - 隣接リスト表現
    - メモリ消費量が辺の数しか必要としない
    - 頂点間の関係を調べるには隣接する頂点を順番に調べる必要がある（O(n)）
    - 連結リストに依存するため辺の削除の操作が効率的でない
  - ![image](隣接行列表現 <https://go.dev/play/p/lRujH0xq7In>)
    - 頂点間の関係を定数時間で確認できる
    - 辺の追加削除を定数時間でおこなえる
    - メモリ消費量が頂点の数の２乗
    - 頂点間の関係を１つしか記録できない
- 探索
  - ![image](深さ優先探索（DFS） <https://go.dev/play/p/fGn1fUFhYzj>)
  - [幅優先探索（BFS）](https://go.dev/play/p/CPGIbfiXRjR)
    - 01-BFS
      - 辺の長さが０または１の有向グラフにおいてある１つの始点から全頂点への最短の長さを求める
      - [01-BFSのちょっと丁寧な解説 - ARMERIA https://betrue12.hateblo.jp/entry/2018/12/08/000020]
- ２部グラフ
  - 各頂点を白または黒でぬったとき、隣接する頂点が異なる色になるグラフのこと
  - [二部グラフ判定をUnionFindTreeで行う - noshi91のメモ https://noshi91.hatenablog.com/entry/2018/04/17/183132]
    - 頂点Xの色わけをするとき、色Aと色BをXとX+nの２種類のグラフで考える
    - 各色を２頂点でわけたUnionFindTreeをつくったときにXとX+nが同じDejointSetに含まれるなら、同じ頂点に両方の色が同時に存在することになり、矛盾するため二部グラフを満たさないことがわかる

# [素集合（DejointSet）](https://go.dev/play/p/Giwmj-8ns6A)

- 互いな素な集合
- １つの要素が複数の集合に属することのない互いに素な集合に分類して管理するためのデータ構造
- Union Find：指定された２つの要素x,ｙが同じ集合な属するか探索する

# [領域探索（kD Tree） https://go.dev/play/p/rm35zu-nrqK]

- 点の集合から二分探索木を生成する
- 二分探索木の根から探索をはじえｍて、ノードに関連づいている点が範囲内に存在するかをチェックしていく
- 更にその子のノードに関しても再帰的に探索をおこなう
- これはk次元の空間に拡張可能なため、kD木と呼ばれるデータ構造を構築することで探索をおこなえる
- 木の深さによってポイントのソートの基準を変更することでk次元に対して探索をおこなう

# Range Minimum Query（セグメント木）

- 要素の値が動的に変化する数列に対して、範囲内の最小の要素を高速に求める[$ O(log(n))]
  - 指定の範囲内の最小値を求める
  - 数列の![image]($ a_i)を更新する
- RMQを実現する別解として![image](Sparse Table <https://ikatakos.com/pot/programming_algorithm/data_structure/sparse_table)による実装がある>
  - 構築に[$ O(nlog(n))]、クエリに[$ O(log(1))]で求められる
  - 値の更新がセグメント木よりも高速におこなえない

# バケット法

列や平面をバケットと呼ばれる任意の単位で分割して、バケットごとにデータを管理することで効率的に計算や操作をおこなう手法

- 平方分割
  - n個の要素からなる列を![image]($ \sqrt n)程度ごとのバケットにまとめて管理する手法
  - 区間に対する処理が[$ O(\sqrt n)]程度でおこなえる
  - セグメント木は各操作が[$ O(logn)]なので、一般的にセグメント木を使うほうが効率的
  - ただし、平方分割のほうが実装がシンプルであったり、セグメント木で実現できない機能も実現可能な場合がある

# Range Sum Query（動的セグメント木）

- 要素の値が動的に変化する数列に対して、範囲内の要素の和を高速に求める

# Suffix Array

- [SA-IS法](https://go.dev/play/p/z0wiPsTRNE1)
  - playground版より大きいデータを扱えるようにした。ただし遅い。
    - [atcoder/suffix_array.go at main · showa-93/atcoder https://github.com/showa-93/atcoder/blob/main/template/structure/suffix_array.go]
  - [Go言語による高速な接尾辞配列の実装(SA-ISの実装) - Qiita https://qiita.com/tobi-c/items/cf450a7b1d6b59f332d1#33-s-typeのソート]
  - [接尾辞配列(Suffix Array) - Shogo Computing Laboratory https://shogo82148.github.io/homepage/memo/algorithm/suffix-array/]
  - [SA-ISで高速にSuffix Arrayを構築する話【新歓ブログリレー 38日目】 | 東京工業大学デジタル創作同好会traP https://trap.jp/post/953/]

# 計算機科学

- [ベクトルライブラリ](https://go.dev/play/p/Dz1kRczJKKk)
- ![image](マンハッタン幾何（線分交差問題） <https://go.dev/play/p/nKpe1kVfSIj>)
- [Closest Pair]
- ![image](Diameter of a Convex Polygon)
  - 凸多角形の直径（＝最遠頂点対間距離）を求める問題
  - キャリパー法
- [Convex Cut]
  - 凸多角形を直線で切断する問題

# 計算量解析

- [調和級数]
  - [調和級数などのはなし - Qiita https://qiita.com/ageprocpp/items/f6661deaa09dda124132]

書籍ででてきたなにか

- [ラウンドロビンスケジューリング](https://go.dev/play/p/H8EZlknKbiH)
  - プロセスの割当手法
  - [ラウンドロビン・スケジューリング - Wikipedia https://ja.wikipedia.org/wiki/ラウンドロビン%E3%83%BBスケジューリング#:~:text=ラウンドロビン%E3%83%BBスケジューリングは%E3%80%81オペレーティング,名前の由来である%E3%80%82]
- [Allocation](https://go.dev/play/p/HwxEcK7XYP9)
