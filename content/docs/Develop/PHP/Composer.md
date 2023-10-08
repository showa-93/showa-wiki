---
title: Composer
type: docs
author: showa
lastmod: 2023-10-08T15:51:16+09:00
waight: 1
---

aptやnpmのようなphp向けのパッケージ管理システム。ライブラリやプロジェクトの依存関係を管理する。  
`composer.json`というファイルでプロジェクトの依存関係を記載し、`composer.lock`で依存するパッケージのバージョンを固定している。  
[Packagist.org](https://packagist.org/)は、Composerのリポジトリ。Composerはなにも指定されていない場合、ここから入手可能なパッケージを自動的に検索し取得する。  

```sh
 sudo apt install php-curl
 php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
 php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
 php composer-setup.php
 php -r "unlink('composer-setup.php');"
 mv composer.phar /usr/local/bin/composer
```

[インストール手順](https://getcomposer.org/download/)

## コマンド

[Command-line interface / Commands](https://getcomposer.org/doc/03-cli.md)

- init
  - プロジェクトの初期設定としてcomposer.jsonを作成する
- self-update
  - Composer自身を最新のバージョンのアップデートする
- install
  - `composer.json`をもとに依存関係を解決しながら`vendor`フォルダにパッケージをインストールする
  - `composer.lock`が存在する場合、記載されたバージョンでインストールする
  - `reinstall`ってのをつかうと指定したパッケージをクリーンインストールできる
- remove <package name>
  - 指定したパッケージを`composer.json`から削除する
- update <package name>
  - `composer.lock`に含まれるパッケージのバージョンを最新にする
  - packageを指定した場合、そのパッケージのバージョンをアップグレードする
- require <package name>
  - `composer.json`のrequireフィールドに追加してインストールする
  - `--dev`オプションを付けた場合、`require-dev`フィールドに追加される
  - code:bash
    - $composer require [package name]
- show
  - 利用できるパッケージのリストを表示する
  - パッケージを指定すると詳細を確認できる
  - `--platform`オプションを指定することでcomposerでインストールできないphpやphpの拡張機能を参照できる
- depends
  - あるパッケージの他のパッケージの依存関係を確認できる

## Composer.json

### パッケージのバージョン指定方法

`composer install`や`composer update`された場合にインストールするバージョンを`composer.json`で指定する方法について

- `x.y.z`
  - 固定のバージョン指定
- `x.y.*`
  - `*`を指定した任意のバージョンの最新のバージョンを取得する
  - パッチバージョンで指定した場合、マイナーバージョン内で最新のパッチバージョンのパッケージを取得
  - マイナーバージョンで指定した場合、メジャーバージョン内で最新のマイナーバージョンのパッケージを取得
- `^x.y.z`
  - 指定したバージョンより最新のパッチバージョンのパッケージを取得
- `~x.y.x`
  - 指定したバージョンより最新のマイナーバージョンのパッケージを取得

### composer内の各キー

[The composer.json schema](https://getcomposer.org/doc/04-schema.md)

- require
  - composer.jsonが配置されたプロジェクトが依存しているパッケージとそのバージョンを記載する
- autoload / autoload-dev
  - composerは`vendor/autoload.php`を生成し、ライブラリが提供するクラスなどをかんたんに利用できるようにしている
  - 自分のソースコードをオートローダーに追加したい場合、このautoloadフィールドに追加することで可能になる
  - `exclude-from-classmap`を設定することで特定のフォルダやファイルをクラスマップから除外できる  

    ```json
    "autoload": {
      "psr-4": {
        "Shoma\\Laratest\\": "src/"
      }
    },
    ```
