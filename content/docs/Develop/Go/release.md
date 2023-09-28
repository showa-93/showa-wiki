---
title: Release
type: docs
weight: 1
---

## [1.21.0](https://tip.golang.org/doc/go1.21)

2023/8リリース

- このマイナーバージョンから`.0`のパッチバージョンがつくようになった
- buildin関数が増えるよ
  - min/max
  - clear  
    mapがデカくなっちゃったままにはならんのかな
- 型推論のパワーアップ
  - ジェネリックな関数の引数としてジェネリックな関数を渡した場合、型引数をわたさなくても関数側の引数の型から型推論されるようになった。
- `go:wasmimport`ディレクティブでWebAssemblyからインポートした関数をGoのプログラムで利用できるようになった
  - ようわからん
- WASIの対応を実験的にはじめた
- 1.20ではいったPGOがbuildコマンドのpgoフラグがデフォルトで`-pgo=auto`になった。
- 追加された関数
  - `log/slog`パッケージ正式リリース
    - slogハンドラーのテスト用に`testing/slogtest`が追加
  - スライスやマップの共通の関数をまとめた`slices`, `maps`パッケージが追加
    - これがジェネリクスの賜物なんだな。
  - `context`
    - `WithoutCancel`：キャンセルされたコンテキストからキャンセル前のコンテキストのコピーを返す。WithValueとかしたやつもコピーされるのかな。
    - `WithDeadlineCause`/`WithTimeoutCause`：タイマー切れのときに原因を設定できるようになる。`Cause`関数で取得できる
    - `AfterFunc`：コンテキストがキャンセルされた後に実行する関数を登録できる
      - cleanup関数登録とかすんのかな

## [1.20](https://tip.golang.org/doc/go1.20)

- カバレッジのプロファイルをコンパイル後のバイナリの実行で取得できるようになった  
  [Coverage profiling support for integration tests - The Go Programming Language](https://go.dev/testing/coverage/)  
  `go build -cover`でカバレッジのプロファイルを出力するバイナリにビルドできる。`-covevrpkg`フラグでカバレッジに含めるパッケージを指定できる。プロフィルが環境変数`COVERDIR`で指定されたディレクトリに出力される。環境変数`COVERDIR`のプロファイルを操作する`go tool covdata`が追加  
  - `go tool covdata percent -i=somedata`でカバレッジの割合が出力される
  - `go tool covdata textfmt -i=somedata -o profile.txt`で`go test`で生成されるプロファイルに変換
  - `go tool covdata merge -i=windows_datadir,macos_datadir -o merged`で複数のOSで実行したプロファイルのマージができる
- プロファイル誘導型最適化（PGO）  
  [Profile-guided optimization - The Go Programming Language](https://go.dev/doc/pgo)  
  CPU pprofファイルをコンパイラのフィードバックとして使用しコンパイラの最適化の決定（FDO）をおこないます。PGOを使用してビルドすると性能が2～4%程度の向上が期待できるコンパイル時のコードが取得したプロファイルのコードから変更されていた場合、変更箇所は最適化の影響をうけない。コンパイラはPGOビルドを繰り返しても最適化のばらつきを防ぐような保守的なつくりになっている。  
  `go build -pgo=auto`でビルドするとdefault.pgoファイルを自動で選択してコンパイルします。go1.20ではデフォルトで`go build -pgo=off`

## [1.19](https://tip.golang.org/doc/go1.19)

## [1.18](https://tip.golang.org/doc/go1.18)

## [1.17](https://tip.golang.org/doc/go1.17)

- [slice型を配列のポインタにキャストできるようになった](https://golang.org/ref/spec#Conversions_from_slice_to_array_pointer)  
 型変換でパニックを起こす可能性がある。
- [go.modに間接的に呼び出されるパッケージが含まれるようになった](https://tip.golang.org/ref/mod#graph-pruning)  
  go get時とかにサブパッケージのgo.modまで読み込む必要がなくなったのかな
- `// +build`だったのが、他に合わせて`//go:build`に変更された
- `go run`でバージョンサフィックス付きで呼び出せるようになった  
  `go run example.com/hoge/cmd@v1.0.0`  
  ファイルをインストールしたり、go.modに変更を及ぼさずに使える  
  - tools.goいらない子。
- コンパイラが関数の引数にレジストリ使うようになって２％処理速度が向上
- testing.Tとtesting.BにSetenvが追加  
  テストに閉じた環境変数を設定できる
