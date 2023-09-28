---
title: ハッシュテーブル
type: docs
weight: 1
---

キーと値の組（エントリ）を格納し、キーに対応するあ愛を高速に参照するためのデータ構造。  
ハッシュテーブルはキーをもとに生成したハッシュ値を添え字とした配列。キーを要約するハッシュ値を添え字として管理することでデータ量によらず定数時間$O(1)$の検索を実現している。  
衝突しやすいハッシュ関数など選んだハッシュ関数によっては最悪の場合$O(n)$となる。  

## ハッシュ関数

ハッシュテーブルで利用されるハッシュ関数は、高速であり、入力データに対して均等に分散されたハッシュ値を生成することが求められます。（**simple uniform hashing**）以下は、ハッシュテーブルでよく利用されるハッシュ関数の一部です。(By ChatGPT)

- **Division Method**  
  キーをテーブルのサイズで割った余りをハッシュ値として使用します。テーブルのサイズを素数にすると、より均等な分散が得られることが多いです。
- **Multiplication Method**  
  キーに定数を掛け、結果の小数部分を取り出して、テーブルのサイズを掛けることでハッシュ値を得ます。
- **Universal Hashing**
- **MurmurHash**
- **CityHash**
- **FNV (Fowler-Noll-Vo) Hash**
- **Jenkins Hash Function**

## ハッシュ値の衝突

ハッシュテーブルはキーをもとに生成したハッシュ値を添え字として利用するが、ハッシュ値は多くの場合入力となるキー全体より小さいため、異なるキー値に同じハッシュ値が生成される可能性がある。（[鳩の巣原理 - Wikipedia](https://ja.wikipedia.org/wiki/%E9%B3%A9%E3%81%AE%E5%B7%A3%E5%8E%9F%E7%90%86)）このハッシュ値の衝突がおきた場合、異なるキーで同じハッシュ値のデータを区別して保管する必要がある。  
衝突が発生したときの対処法としては、チェイン法（Chaining/連鎖法）とオープンアドレス法（Open Addressing/開番地法）に大別される。  

### チェイン法（Chaining）

衝突したキーのエントリを連結リストとしてもつ方式。  
配列にはエントリそのものではなく、連結リストを格納する。  

### オープンアドレス法（Open Addressing）

キーが衝突した場合、テーブルの中の開いている別のスロットを探索する方式。ハッシュ関数とは別の関数で次の候補となるスロットを求める。（再ハッシュ）  
ただし、テーブルからキーを削除したときにスロットに格納されたデータを空にすると問題が発生する。削除されたキーよりあとに候補になるスロットにあるキーを検索した場合、削除されたスロットで走査が終了してしまいキーが存在しないことになってしまう。そのために削除を示す状態を保持する必要がある。  
メモリ使用効率が高いが、テーブルが満杯に近づくと性能が低下する可能性がある。  

#### 線形探査（Linear Probing）

- [Linear probing - Wikipedia](https://en.wikipedia.org/wiki/Linear_probing)
- [lecture12-hash2.pdf](https://courses.cs.washington.edu/courses/cse326/02wi/lectures/lecture12/lecture12-hash2.pdf)

ハッシュ値から求めたスロットが衝突していた場合、次のスロットを順番に調べて最初の空きスロットにデータを格納する。パフォーマンスを維持するならload factorが0.5程度になったときresizeするのが目安。  
$h'(k)=(h(k)+1) mod(m)$  

この方法の主な問題点として[Primary clustering](https://en.wikipedia.org/wiki/Primary_clustering)が知られている。  
線形探索によって連続するスロットが埋まることでクラスタ（連続するスロットのグループ）が形成されると、そのクラスタ内の衝突の確率が高くなる。クラスタは時間とともに成長し、ハッシュテーブルの性能が低下する。  

#### 二次探査（Quadratic Probing）

次のスロットを任意の実数のi乗($0<=i<m$)のステップでスロットを順番に調べて最初の空きスロットにデータを格納する。  
ハッシュテーブル全体に均一なレコード分布を得られる利点がある。  
$h'(k)=(h(k)+c_1^i+c_2^{i^2}) mod(m)$  

線形探査と異なり、クラスタが発生しないためPrimary clusteringがおきないようになっている。  
しかし、異なるキーが同じスロットにハッシュされた場合、同じ探査シーケンスをもつため、特定のスロット周辺で衝突が頻発する可能性がある。この問題を[secondary clustering](https://xlinux.nist.gov/dads/HTML/secondaryClustering.html)と呼ぶ。  

#### 二重ハッシング（Double Hashing）

- [Double Hashing - GeeksforGeeks](https://www.geeksforgeeks.org/double-hashing/)

2つの独立したハッシュ関数を使って衝突の解決をおこなう。  
$h'(k)=(h_1(k)+i \times h_2(k))mod(m) (i \in (1..m-1))$  
1つ目のハッシュ関数$h_1$では最初のスロットを決めるためのハッシュ値を求める。2つ目のハッシュ関数$h_2$で次のスロットをみつけるためのステップの大きさを求める。  

利点として、空きスロットを探索するステップの値を別のハッシュ関数を利用しているため、初期位置が同じでも探索範囲がことなるため衝突の発生確率がさがる。問題点としては、２つのハッシュ関数による計算の必要があるため、挿入と探索の計算量が増える可能性がある。また、２つのハッシュ関数が互いに素でなければ衝突確率が高くなる可能性がある。  

#### Cuckoo hashing

- [Cuckoo hashing - Wikipedia](https://en.wikipedia.org/wiki/Cuckoo_hashing)
- [Cuckoo Hashing - Radium Software](https://kzr-2.hatenadiary.org/entry/20080531/p2)
- [Cuckoo Hashing - Worst case O(1) Lookup! - GeeksforGeeks](https://www.geeksforgeeks.org/cuckoo-hashing/)
- [A cool and practical alternative to traditional hash tables](http://www.ru.is/faculty/ulfar/CuckooHash.pdf)
- [GolangでBucketized Cuckoo Hashingを実装してみた - 逆さまにした](https://cipepser.hatenablog.com/entry/2017/06/17/103154)

衝突解決のための処理がカッコウの雛が孵化したら巣の鳥の卵を捨ててしまうカッコウの習性と類似していることが名前の由来。  
他の手法と異なり、エントリの検索が最悪でも定数時間$O(1)$内で完了する。  
Cuckoo hashingでは２種類のハッシュ関数$h_1$, $h_2$と２つのテーブル$T_1$, $T_2$を使用する。  

キー$x$をハッシュテーブルに挿入する場合を考える。$T_1$の$h_1(x)$のスロットにキー$x$のエントリを格納する。このときスロットに既にエントリが存在した場合、古いエントリのキー$y$をもう一方のテーブル$T_2$に格納する。この追い出して格納の処理が完了するまで繰り返すことでエントリを挿入する。作成されたテーブルにはキー$x$が$T_1$または$T_2$のどちらかに入っていることが保証されるため、最悪２回の検索で見つけることができる。  
ただし、エントリの挿入時に循環参照になった場合、追い出し処理が完了しないため処理回数に上限をつけテーブルをrehashする必要がある。load factorが0.5を超えない限り挿入コストは$O(1)$が保たれる。0.5を超えた場合、性能低下することがしられている。  

#### Hopscotch hashing

- [Hopscotch hashing - Wikipedia](https://en.wikipedia.org/wiki/Hopscotch_hashing)
- [よくわかるHopscotch hashing](https://www.slideshare.net/kumagi/hopscotch-hashing)
- [Hopscotch Hashing | Programming.Guide](https://programming.guide/hopscotch-hashing.html)

#### Robin Hood Hashing

- [Road to Clustered Hashing: Robinhood Hashing Revisioned | Programmer’s Digest](https://jasonlue.github.io/algo/2019/08/20/clustered-hashing.html)

## [load factor](https://xlinux.nist.gov/dads/HTML/loadfactor.html)とRehash

ハッシュテーブルはエントリの数が配列のサイズに近づくほど衝突の確率が高くなり性能が悪化する。  
この比率を**load factor**（座席利用率）と呼び、$n/m$の形で表す。$n$はエントリの数、$m$は配列のサイズを指す。  

チェイン法の場合、load factorの増加に対して線形に性能が悪化する。  
オープンアドレス法では衝突したキーが空いた番地に格納されるため、load factorが0.7~0.8付近から急激に性能が悪化する。  

この問題を回避するためにload factorが一定の値を超えた場合、より大きいハッシュテーブルを用意して格納しなおす**rehash**が必要になる。  
すべての要素を再計算した場合、必要な計算量は$O(n)$程度となる。  
rehashせずにあらかじめ十分なサイズの配列を用意する方法もあるが、エントリ数を事前に想定できない場合は適用できない。  

### rehashの高速化

テーブルのサイズに合わせて素直にハッシュ値を計算し直そうとすると$O(n)$だけ時間がかかるため、テーブルのサイズがおおきくなるにつれて時間がかかる。  
以下にrehashの速度の向上させる方法について列挙する。  

- [Incremental Resizing](https://jasonlue.github.io/algo/2019/09/03/clustered-hashing-incremental-resize.html)  
  一度にエントリをrehashするのではなく、各操作（挿入、削除、検索）の後にエントリを古いテーブル（古いテーブルのスロットの位置）から新しいテーブルに移動する。rehashのコストを各操作に分散できる。  
- 並列rehash
- ハッシュ関数の計算速度の向上
- テーブルサイズ
- メモリの事前確保
- データの局所性の利用

## 並行ハッシュテーブル

## 参考

- [ハッシュテーブル - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB)
- [あなたの知らないハッシュテーブルの世界 | ドクセル](https://www.docswell.com/s/kumagi/ZGXXRJ-hash-table-world-which-you-dont-know#p30)
- [Hash Table - Zenn](https://zenn.dev/peg/articles/0fc98092e88a21)
- [Road to Clustered Hashing: Robinhood Hashing Revisioned | Programmer’s Digest](https://jasonlue.github.io/algo/2019/08/20/clustered-hashing.html)
- [Hash Tables Implementation in Go. The inner implementation. A story (for… | by Gopher | gopherstalk | Medium](https://medium.com/kalamsilicon/hash-tables-implementation-in-go-48c165c54553)
- [(1) Lecture 8: Hashing with Chaining - YouTube](https://www.youtube.com/watch?v=0M_kIqhwbFo&list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb&index=9)
