---
title: Generics
type: docs
author: showa
lastmod: 2023-10-09T03:44:46+09:00
waight: 1
---

## 型制約・型パラメータ

関数のパラメータはgo1.17以前ではパラメータの型によって制限された値の集合の範囲にあった。go1.18でジェネリクスが導入され、関数や型は型パラメータをもつことができるようになった。型パラメータによって、関数のパラメータや型が満たすべき型の制約（性質）を定義できるようになった。  
型パラメータはインターフェース型で型のセットを定義できる。ジェネリクスの導入によってインターフェース型はメソッドの集合という定義から型の集合を定義するように仕様が変更された。この変更によって以前はメソッドによって間接的に型を制限していたが、明示的に型の集合を定義できるようになった。  
go1.18より前と異なり、インターフェース型を実装するというのはインターフェース型でない型Tの場合、満たすべきインターフェース型が定義する型集合の要素であることが必要である。型Tがインターフェース型である場合、満たすべきインターフェース型が定義する型集合の部分集合であれば実装している。  

| 集合 | 型 | 説明 |
|:--|:--|:--|
| 任意の型 | interface { AnyType } | 任意の型の集合 |
| 型の和集合 | interface { int \| string } | 複数の型の和集合 <br> 型制約としてしか利用できない <br> メソッドをもつインターフェース型では利用できない |
| 基底型 | interface { ~int64 \| ~float64 } | 基底型を満たす型の集合 |

基本的な型制約は[constraintsパッケージ](https://pkg.go.dev/golang.org/x/exp/constraints)で提供される。  
型制約は型パラメータが許容する型を指定するものだけでなく、型パラメータが可能な操作を定義します。メソッドセットで定義された関数や`+`や`*`のような算術演算やビット演算なども型パラメータによって許可される。  

### comparable type

演算とは異なり、等式など比較が可能かどうかの型制約はcomparableの型集合によって定義される。  
ただし、comparableによる型集合と言語仕様の型の集合（`spec-comparable`）は同等ではない。anyなどのインターフェースで実際の値がcomparableでない場合、比較時にruntime panicが発生します。comparableには比較時にパニックをおこさないことを保証している型だけが含まれます。このような型を`strictly comparable`と呼ぶ。  

go1.20から`strictly comparable`でなかったany型もcomparableとして扱えるようにcomparableはインターフェースの実装（`implement comparable`）と型引数を型パラメータにわたすときの制約充足（`satisfy comparable`）を区別するようになった。つまり、`implement comparable`が`strictly comparable`を満たし、`satisfy comparable`が`spec-comparable`を満たすようになります。  

以下の例を考える。

```go:satisfy_comparable.go
func f[T comparable](x, y T) {
  if x == y { // (4)
    fmt.Println("Same!!!")
  }
}

func g[P any]() {
  _ = f[int] // (1)
  _ = f[P]   // (2)
  _ = f[any] // (3)
}
```

3番目のケースでは`any`型は空のインターフェースなのでcomparableを満たす（`satisfy comparable`）。ただし、`any`型はcomparableを実装しないので、comparableでない値を引数に渡した場合、(4)でruntime panicが発生します。これは`implement comparable`と区別されたことで**厳密な型安全性をもたなくなった**ためである。  
2番めのケースでは`P`型は`any`型で制約されたパラメータなので、すべてのパラメータがcomparableを満たさないので、comparableを満たさない。  

### 型のメソッドが独自にジェネリクスをもてない理由

型推論に成功したら、インスタンス化がおこなわれる。インスタンス化は型パラメータに実際に型推論された型パラメータを代入した型がインスタンス化される。そのため、型に定義されたメソッドは型のインスタンスが生成された時点で確定するため、個別のメソッドがジェネリクスによる型推論によるインスタンス化をおこなうことはできない。  

以上が自分の理解。  

### 参考

[Go言語のジェネリクス入門(1) https://zenn.dev/nobishii/articles/type_param_intro]
[Go言語のジェネリクス入門(2) インスタンス化と型推論 https://zenn.dev/nobishii/articles/type_param_intro_2]
[Go言語のBasic Interfaceはcomparableを満たすようになる(でも実装するようにはならない) https://zenn.dev/nobishii/articles/basic-interface-is-comparable]
[All your comparable types - The Go Programming Language https://go.dev/blog/comparable]
[Core Types | The Go Programming Language Specification - The Go Programming Language https://go.dev/ref/spec#Core_types]
