---
title: 言語仕様
type: docs
author: showa
lastmod: 2023-10-09T03:48:38+09:00
waight: 1
---


- Goの言語仕様における表現方法：[EBNF - Wikipedia](https://ja.wikipedia.org/wiki/EBNF)
- [Template:General Category (Unicode) - Wikipedia](https://en.wikipedia.org/wiki/Template:General_Category_(Unicode))

## Lexical elements

### Token

- identifiers
- keywords
- operators and punctuation
- literals

ホワイトスペース（スペース（U+0020）、水平タブ（U+0009）、キャリッジリターン（U+000D）、ニューライン（U+000A））は、トークンを分離する場合を除き、無視されます。  
また、開業やファイルの終端があるとセミコロンが挿入されることがある。  

### Semicolon

生成物の終端にセミコロンを使用している。ただし、以下のルールでセミコロンを省略できる。  

- 以下のトークンであれば、行の最後のトークンの直後に自動的にセミコロンが挿入される
  - identifiers
  - 整数、浮動小数点、虚数、ルーン、または文字列リテラル
  - break、continue、fallthrough、returnのいずれかのキーワード
  - [演算子および句読点](https://go.dev/ref/spec#Operators_and_punctuation)の中の++、--、）、 ] 、 } のいずれか。
- 文を１行にまとめるために、)や}で閉じる前のセミコロンを省略できる

### Identifiers

変数や型などのプログラムの実態をあらわす。  
`identifier = letter { letter | unicode_digit } .`  

[その他の識別子](https://go.dev/ref/spec#Predeclared_identifiers)  

### Keywords

予約済みのキーワード

```txt:keywords
 break        default      func         interface    select
 case         defer        go           map          struct
 chan         else         goto         package      switch
 const        fallthrough  if           range        type
 continue     for          import       return       var
```
