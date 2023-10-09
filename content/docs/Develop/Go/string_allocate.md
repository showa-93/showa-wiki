---
title: Goで文字列のポインタ参照でアロケート
type: docs
author: showa
lastmod: 2023-10-09T03:36:22+09:00
waight: 1
---

## 結論

- 文字列の変数のスコープがポインタ参照によって関数より外に広がったことでheapに割り当てられる
- これは実際にポインタ参照されるところまでコードが到達しなくても関数を呼び出した時点で発生する
  - （あたり前田のクラッカー）
- そのため、該当箇所まで到達しなくてもメモリアロケートが発生する

勉強不足。この修正でライブラリの性能ちょっとあがったので学び。

### 調べた

遭遇したのはこんな感じのreflectで文字列を操作したときにみつけた。
※再現確認のために超簡単な内容にしている。

```go:main.go
package main

import "reflect"

func main() {
  stringToString("XXX")
}

func stringToString(s string) string {
  if s != "" {
    return s
  }

 return reflect.ValueOf(&s).Elem().String() // ← ここには到達しない
}
```

到達しないが、Benchmarkとると1allocs走ってる

```bash
> go test -bench $ -benchmem -benchtime 5s string-test
goos: linux
goarch: amd64
pkg: string-test
cpu: Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz
BenchmarkReflectString-8        217355878               27.66 s/op           16 B/op          1 allocs/op
```

なんでだろ～。reflect.ValueOf～を別の関数にしてみる。

```go:main.go
package main

import "reflect"

func main() {
  stringToString("XXX")
}

func stringToString(s string) string {
  if s != "" {
    return s
  }

 return valueOfString(s).String()
}

func valueOfString(s string) reflect.Value {
  return reflect.ValueOf(&s).Elem()
}
```

Benchmarkをとるとallocsがゼロになった！  

```bash
> go test -bench $ -benchmem -benchtime 5s string-test
goos: linux
goarch: amd64
pkg: string-test
cpu: Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz
BenchmarkReflectString-8        1000000000               1.391 ns/op           0 B/op          0 allocs/op
```

次にbuildで`gcflags`フラグをつかってコンパイル時の最適化の内容をみてみる。  

まず前者のメモリアロケートが発生するパターン。  
stringToString関数で変数`s`がヒープに移動されている。つまり、stringToString関数が呼び出すと引数の変数`s`はスタックじゃなくてヒープにおかれる。  

```bash
> go build -gcflags '-m' main.go
# command-line-arguments
./main.go:14:24: inlining call to reflect.ValueOf
./main.go:14:42: inlining call to reflect.Value.String
./main.go:14:24: inlining call to reflect.escapes
./main.go:14:24: inlining call to reflect.unpackEface
./main.go:14:24: inlining call to reflect.(*rtype).Kind
./main.go:14:24: inlining call to reflect.ifaceIndir
./main.go:14:42: inlining call to reflect.flag.kind
./main.go:5:6: can inline main
./main.go:9:21: moved to heap: s
```

次に後者。  
stringToString関数で`leaking param`が起きている。これはぐぐると[Goのコンパイル時の最適化結果を確認する（インライン化の条件についても記載） - Qiita](https://qiita.com/ryskiwt/items/574a07c6235735afa5d7#leaking-param)より、関数が終わっても変数が残るというアラート。なので、関数呼び出し時点ではヒープに変数が置かれてはいない。  

```bash
> go build -gcflags '-m' main.go
# command-line-arguments
./main.go:19:24: inlining call to reflect.ValueOf
./main.go:19:24: inlining call to reflect.escapes
./main.go:19:24: inlining call to reflect.unpackEface
./main.go:19:24: inlining call to reflect.(*rtype).Kind
./main.go:19:24: inlining call to reflect.ifaceIndir
./main.go:15:32: inlining call to reflect.Value.String
./main.go:15:32: inlining call to reflect.flag.kind
./main.go:5:6: can inline main
./main.go:18:20: moved to heap: s
./main.go:9:21: leaking param: s
```

別に関数にしなくても別の変数に置き換えても問題なし。

```go:main.go
func stringToString(s string) string {
  if s != "" {
    return s
  }
  t := s
  return reflect.ValueOf(&t).Elem().String()
}
// > go test -bench $ -benchmem -benchtime 5s -memprofile mem.out string-test
// goos: linux
// goarch: amd64
// pkg: string-test
// cpu: Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz
// BenchmarkReflectString-8        1000000000               1.476 ns/op           0 B/op          0 allocs/op
```
