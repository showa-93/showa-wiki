---
title: Zig
type: docs
author: showa
lastmod: 2023-12-12T03:35:34+09:00
waight: 1
---

## Manual Install / Update

```bash
version="0.11.0"
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-${version}.tar.xz && sudo rm -rf /usr/local/zig && sudo mkdir /usr/local/zig && sudo tar -C /usr/local/zig -xvf zig-linux-x86_64-${version}.tar.xz --strip-components 1 && rm -r zig-linux-x86_64-${version}.tar.xz
wget https://github.com/zigtools/zls/releases/download/${version}/zls-x86_64-linux.tar.gz && sudo rm -rf /usr/local/zls && sudo mkdir /usr/local/zls && sudo tar -C /usr/local/zls -xzf zls-x86_64-linux.tar.gz --strip-components 1 && chmod +x /usr/local/zls/bin/zls && rm -r zls-x86_64-linux.tar.gz
```

## Language Server

[zigtools/zls: The @ziglang language server for all your Zig editor tooling needs, from autocomplete to goto-def!](https://github.com/zigtools/zls)

## Spec

### Peer Type Resolution

Zigの**Peer Type Resolution**は、コンパイラが複数の値の型を比較して適切な共通型を導き出すためのメカニズムです。このプロセスにより、特に`comptime`制約がある場合や型推論が必要な場面で、異なる型の値が一緒に使用される際に互換性を持たせることができます。

以下のように動作します：

- 異なる式が同じコンテキスト（例えば、条件演算子の両側のブランチや配列リテラルの要素）で使用されるとき、これらの式の戻り値の型は「peer」と見なされます。
- コンパイラはそれらの「peer」の間で互換性のある型を解決しようと試みます。例えば、整数リテラルが含まれている場合、これらは最も広い範囲を持つ符号付きまたは符号なしの整数の型に昇格することがあります。
- プログラマが型注釈を提供していない場合でも、Zigコンパイラは可能な限り最適な型を選択します。
- 解決が不可能な場合は、コンパイラはエラーを返し、プログラマに修正を求めます。

例として、次のような条件演算子があると考えましょう：

```zig
const a = if (condition) 10 else 20;
```

ここで、`10`と`20`は整数リテラルです。Zigコンパイラはこれらのリテラルの型を解決するためにPeer Type Resolutionを使用し、`a`の型を`i32`として解決する可能性が高いです（`i32`はデフォルトの整数型です）。

Peer Type Resolutionの挙動はアップデートやZig言語のバージョンによって変更されることがあるので、具体的な挙動を知るためにはZigのドキュメントを参照したり、実際にコードを試したりすることが重要です。

## Link

- [Zig Language Reference](https://ziglang.org/documentation/0.11.0/)
- [他言語習得者がとりあえず使えるようになるZig](https://zenn.dev/drumato/books/learn-zig-to-be-a-beginner)
