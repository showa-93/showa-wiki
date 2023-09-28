---
title: Test
type: docs
weight: 1
---

## Benchmark

関数名の接頭辞に`Benchmark`をつけて`*testing.B`を受け取る関数をつくるとベンチマークをとれる。  
`-benchmem`でベンチマーク中のメモリの情報がとれる。  

### profileをとる

- `-cpuprofile [ファイルパス]`: ベンチマーク中のCPUのプロファイルを取得し出力します。
- `-memprofile [ファイルパス]`: ベンチマーク中のmemoryアロケーションのプロファイルを取得し出力します。
- `-trace [ファイルパス]`: ベンチマーク中のtraceを取得し出力します。
- `-gcflags`: gcコンパイラにわたすフラグを設定できる。`-m`を渡すと最適化の結果を確認できる。

```bash
go test -benchmem -cpuprofile pprof/cpu.out -memprofile pprof/mem.out -bench BenchmarkCtable github.com/showa-93/hashing/hashtable
```

取得したprofileをwebで参照する。

```bash
go tool pprof -http ":8080" pprof/cpu.out
```

## 参考

- [Profile your golang benchmark with pprof | by Felipe Dutra Tine e Silva | Medium](https://medium.com/@felipedutratine/profile-your-benchmark-with-pprof-fb7070ee1a94)
- [go buildのオプションを調べてみた](https://zenn.dev/hiroyukim/articles/ccb937039e5747#-gcflags-%3A-gc%E3%81%B8%E6%B8%A1%E3%81%99%E3%83%95%E3%83%A9%E3%82%B0)
- [goで書いたコードがヒープ割り当てになるかを確認する方法 · hnakamur's blog](https://hnakamur.github.io/blog/2018/01/30/go-heap-allocations/)
