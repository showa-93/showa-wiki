---
title: Action Domain Responder
type: docs
author: showa
lastmod: 2023-10-08T14:36:02+09:00
waight: 1
---

>Action-domain-responder（ADR）は、Webアプリケーションにより適したModel-view-controller（MVC）の改良版としてPaul M. Jonesによって提案されたソフトウェアアーキテクチャパターンです.
MVCと最も異なる部分は、１つのパスに対して１つのAction Classであることがあげられる。
コントローラの場合、複数のパスがメソッドによって表現されるが、これによってあるメソッドでは必要でも他のメソッドでは必要のない依存関係などがうまれたり、クラス内の複雑性は変更が加えられるたびにFatになっていく。（そして神クラスへ...）
ADRでは、１つのActionでは１つのパスしか表現できないので、こうしたクラスの肥大化を防ぐことができる。
また、responseを返す部分をResponderとして切り分けられているため、より疎結合な実装が可能になる。

![x](https://scrapbox.io/files/6102c9f4853291001c0c03c1.png)

- [Lumen/Laravel Action-Domain-Responder(ADR)アプローチ](https://qiita.com/ytake/items/db8cb64493f08f5b9706)
- [ADRの親が贈るAction Domain Responder(ADR)を実装する際の注意点の和訳](https://qiita.com/kahirokunn/items/6ab9b535ee29121d16ee)
- [LaravelでのADR（Action-domain-responder）実装](https://www.ritolab.com/entry/164)
