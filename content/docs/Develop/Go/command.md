---
title: Command
type: docs
author: showa
lastmod: 2023-10-09T03:22:19+09:00
waight: 1
---

## go get

go.modファイルにあるモジュールの依存関係を更新し、パッケージをビルドしてインストールする。
モジュールとバージョンが解決できたら、require命令を追加、変更、削除する。
go.modのrequireディレクティブの管理に重点を置いている。

```bash
go get

# a specific module
# 暗黙的に@upgrade queryが使われる
# go get -d golang.org/x/net@upgrade
go get -d golang.org/x/net

# all modules
go get -d -u ./...
go get -d -u all

# a specific version
go get -d golang.org/x/text@v0.3.2

# a specific branch name or revision
go get -d golang.org/x/text@master

# @none suffixでモジュールの削除ができる
go get golang.org/x/text@none
```

### サポートされているフラグ

- `-d`
  - ビルドやインストールを行わないように指示する
  - `-d`なしで`go get`を使うことは非推奨です。
  - Go1.18からデフォルトで有効になる
- `-u`
  - パッケージからインポートされたパッケージを提供するモジュールをアップグレードするように指示する
- `-u=patch`
  - 最新のパッチバージョンにアップグレードする
- `-t`
  - 指定されたパッケージのテストを動作させるために必要なモジュールも含めるように指示する
- `-insecure`
  - `http`のような安全でないスキーマから取得することを許可する
  - 非推奨

## go install

パッケージをビルドしてインストールする。実行ファイルは`$GOBIN`で指定されたディレクトリにインストールされる。`$GOROOT`にある実行可能ファイルは`$GOBIN`ではなく、`$GOROOT/bin`または`$GOTOOLDIR`にインストールされる。  
Go1.16以降、引数にバージョンのさフィクスがある場合、モジュールを考慮したモードでパッケージをビルドする。このとき、カレントディレクトリや親のディレクトリにgo.modがある場合、go.modを無視する。  

```bash
go install
# go install [build flags] [packages]
```

## go list -m

mフラグでモジュールをリストアップする。

```bash
go list -m
# go list -m [-u] [-retracted] [-versions] [list flags] [modules]
go list -m all
go list -m -versions example.com/m
go list -m -json example.com/m@latest
```

### サポートされているフラグ

- `-f`
  - フラグでフォーマットテンプレートを適用する。
- `-u`
  - 利用可の名アップグレードに関する情報を追加する
- `-versions`
  - そのモジュールのすべての既知のバージョンをセマンティックバージョニングに従って順番にリストアップする
  - `retracted`フラグが指定されない場合、撤回されたバージョンは一覧から省かれます

## go mod download

指定されたモジュールをモジュールキャッシュにダウンロードします。  
引数なしの場合、メインモジュールのすべての依存関係を適用される。  
goコマンドは必要に応じて自動的にモジュールをダウンロードします。モジュールキャッシュの事前ロードやプロキシが提供されるデータのロードに有用。  

```bash
go mod download
# go mod download [-json] [-x] [modules]
go mod download
go mod download golang.org/x/mod@v0.2.0
```

### サポートされているフラグ

- `-json`  
  ダウンロードされた各モジュールについてのJSONオブジェクトを標準出力に出力する
- `-x`  
  ダウンロードが実行するコマンドを標準エラーに出力する

## go mod edit

go.modファイルの編集や書式設定のためのインターフェース。  

```bash
go mod edit
# go mod edit [editing flags] [-fmt|-print|-json] [go.mod]
go mod edit -replace example.com/a@v1.0.0=./a
go mod edit -json
```

### サポートされているフラグ

- `-module` go.modファイルのモジュールの行を変更する
- `-go=version` 動作に期待するGoのバージョンをセット
- `-require=path@version` 与えられたモジュールをrequireディレクティブに追加・削除
  - 記載の上書きを行うだけなので、必要な変更をおこなう`go get`を利用すべき
- `exclude=path@version` excludeディレクティブに追加・削除をおこなう
- `-replace=old=new` 与えられたペアのreplaceディレクティブに追加する
- `-dropreplace=old` 与えられたモジュールパスのreplaceディレクティブをドロップする
- `retract=version` `dropretract=version` retractディレクティブに追加・削除をおこなう。ただしコメントは記載できない

- 出力方法の操作
  - `-fmt` 他の変更を加えずにgo.modファイルの再フォーマットをおこなう。ほかのフラグが指定されていない場合にだけ利用できる
  - `-print` go.modへの書き込みをする代わりに標準出力する
  - `-json` go.modへの書き込みをする代わりにjson形式で標準出力する

## go mod graph

replace適用後のrequireディレクティブのテキスト形式を表示する。  
各行はモジュールのバージョンと依存関係をもつグラフのエッジを表現する。  

```bash
go mod graph
# go mod raph [-go=version]
```

## go mod init

カレントディレクトリに新しいgo.modファイルを初期化して書き込む。  
vendoringツールの設定ファイルが存在する場合、その設定ファイルからモジュールディレクティブをインポートする。  

```bash
go mod init
# go mod init [module-path]
```
