---
title: Laravel
type: docs
author: showa
lastmod: 2023-10-09T04:10:34+09:00
waight: 1
---

Symphonyベースのフルスタックなフレームワーク。

```sh:install.sh
sudo apt install php-mbstring php-xml
composer global require laravel/installer
# $HOME/.composer/vendor/binにパスを通しておくと使えるyo
laravel new example-app
```

バージョンアップ間隔

|  | 間隔 | Bug fix | Security fix | メモ |
|:--|:--|:--|:--|:--|
| メジャーリリース | ６ヶ月 | ７ヶ月 | １年 | Laravel 9以前 |
|  | １年 | １年半 | ２年 | Laravel 9以降 |
| LTS | ２年 | ２年 | ３年 | Laravel 6 2021/7/29時点 |

`public/index.php`を起点にリクエストをパスルーティングして処理している。

## サービスコンテナ

サービスコンテナの実体  `Illuminate\Foundation\Application`
アプリケーションでよく使われる共通の機能の生成やインスタンスのキャッシュなどのインスタンスの管理をする役割を担う。サービスコンテナが生成やDIへの責任を持つため、利用側は設定や初期化などを気にする必要がなくなる。  

![hoge](https://scrapbox.io/files/610287997a99eb001d112d81.png)

- バインド
  - サービスコンテナに対してインスタンスの生成方法を登録する処理
  - bind/bindf/singleton/instanceメソッドなどで登録する
  - Providers/AppServiceProviderクラス内などProvidersにバインドを定義する
- 解決
  - makeメソッドやapp関数を利用することで名前から解決したインスタンスを取得する
  - Class名ならbindされてなくてもインスタンス生成は可能
    - ただのリフレクションやん
  - when/need/giveを利用すると注入先クラスによってサービスコンテナで解決するクラスを変更できる
    - adminだったらこのクラス、userだったらこのクラスみたいに。

## ファサード

クラスメソッド形式でフレームワークの機能をかんたんに利用できる。  
サービスコンテナをベースに実現されているらしい。  
マジックメソッド`__callStatic`を使ってサービスコンテナで解決したインスタンスのメソッドを呼び、あたかもクラスメソッド形式で読んでいるようにみせている。密ですね。  

## サービスプロバイダ

ビジネスロジックの実行前にサービスプロバイダーが呼び出される  

- サービスコンテナへのバインド
- イベントリスナーやミドルウェア、ルーティングの登録
- 外部コンポーネントの読み込み  
registerメソッド⇛（任意）bootメソッドの順に実行して処理をおこなうよ  
`DeferrableProvider`を実装するとサービスプロバイダーで呼び出されるまで読み込みを遅延させることができる。  

### コントラクト

Laravelのコアコンポーネントで利用されている関数をインターフェースで定義したもの。このコントラクトを実装したクラスでコアコンポーネントの差し替え（Providerで再バインド）が可能。  

### クライアント

- [HTTPクライアント](https://readouble.com/laravel/8.x/ja/http-client.html)
  - [guzzlehttp/guzzle](https://docs.guzzlephp.org/en/stable/)をラップしたクライアント
  - Laravel 7.x以降から導入された

### [ミドルウェア](https://readouble.com/laravel/8.x/ja/middleware.html)

- グローバルミドルウェア
  - ルーターに登録されたコントローラの動作前に実行
  - ルート情報を取り扱うような処理はおこなえない
- ルートミドルウェア
  - ミドルウェアを特定のルートに指定したい場合に利用する
  - Routeのmiddlewareメソッドで指定することができる
  - ミドルウェアグループという形で一括でmiddlewareを指定できる形にもできる

## Sail

[Laravel sail](https://readouble.com/laravel/8.x/ja/sail.html)  

LaravelのデフォルトのDocker開発環境を操作するためのCLI。Laravelのアプリケーションを構築するための出発地点を提供するよ。  

```sh:既存のアプリにSailを導入.sh
> composer require --dev laravel/sail
# docker-composeを生成するよ
> php artisan sail:install
Which services would you like to install? [mysql]:
  [0] mysql
  [1] pgsql
  [2] mariadb
  [3] redis
  [4] memcached
  [5] meilisearch
  [6] minio
  [7] mailhog
  [8] selenium
> ./vendor/bin/sail up -d
> alias sail="./vendor/bin/sail"
# コンテナのmysqlに直接アクセスできるコマンドも用意しているよ
> sail mysql
```

## 参考

[Laravel で DDD のレイヤードアーキテクチャを試す](https://zenn.dev/yuuan/articles/54e588ac7e9ae1)
