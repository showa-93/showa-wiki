---
title: TypeScript
type: docs
author: showa
lastmod: 2023-10-09T04:44:26+09:00
waight: 1
---

## Enum

数値列挙、文字列列挙が可能
静的関数をもたせられる

```ts
enum Group {
  Admin,
  Member,
  Guest
}
namespace Group {
  export function idAdmin(group: Group): boolean {
    switch (group) {
    case Group.Admin:
      return true
    default:
      return false
    }
  }
}
```

## lib.d.ts

TypeScriptに含まれるJavaScriptランタイムとDOMに存在するさまざまな一般的なJavaScriptを構成する機能のアンビエント宣言が含まれている。

- このファイルは、TypeScriptプロジェクトのコンパイルコンテキストに自動的に含まれます
- このファイルの目的は、JavaScriptやTypeScriptのプロジェクトで、すぐに型のサポートを得られるようにすることです

## 型ガード

- 参考
  - [ユーザー定義型ガード、asで書くかanyで書くか](https://blog.uhy.ooo/entry/2021-04-09/typescript-is-any-as/)
- `typeof`（組み込み型）や`instanceof`（classのオブジェクト）で型の判定
- `in`演算子でオブジェクトのプロパティをチェックすることで型ガードできる
- プロパティにあるリテラル型をチェックすることで型のチェックができる
- nullとundefinedのチェックは、`==null`/`!=null`でできる
- コールバック関数内まで外側の型ガードの情報が有効にならない
  - 変更されないことを保証する必要がある

```ts
type Foo = {
  kind: 'foo', // Literal type
  foo: number
}
type Bar = {
  kind: 'bar', // Literal type 
  bar: number
}

function doStuff(arg?: Foo | Bar | null) {
  if (arg == null) {
    console.log("null or undefined")
    return
  }
  if ('foo' in arg) {
    console.log(arg.foo)
  }
  if (arg.kind === 'foo') {
    console.log(arg.foo); // OK
  } else {  // MUST BE Bar!
    console.log(arg.bar); // OK
  }
}
```

- ユーザー定義の場合、型ガード関数をユーザーで定義する

```ts
interface Foo {
  foo: number;
  common: string;
}

// trueの場合、`arg is Foo`で引数の型のヒントをあたえられる
function isFoo(arg: any): arg is Foo {
  return arg.foo !== undefined;
}
```

## keyof

オブジェクト型のプロパティからUnion型を抽出する

```ts
type hoge = {
  Neko: string
  Inu: string
}

type animal = keyof hoge
let hoge: animal // type is Inu | Neko
hoge = 'Inu'
```

## in

型に`[xx in yy]`でプロパティ名にユニオン型を展開できる。

```ts
type animal = 'Cat' | 'Dog'
type names = {[a in animal]: string}
let n: names = {
  Cat: 'Tama',
  Dog: 'Pochi'
}
```

## intrinsic

実装がコンパイラの内部実装として隠蔽されていることを意味するキーワード。
構文を追加しないようにする工夫的なサムシングらしい。
[TypeScript 4.1で密かに追加されたintrinsicキーワードとstring mapped types](https://zenn.dev/uhyo/articles/typescript-intrinsic)

[TypeScript Deep Dive](https://typescript-jp.gitbook.io/deep-dive/)
