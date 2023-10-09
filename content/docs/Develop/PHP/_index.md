---
title: PHP
type: docs
author: showa
lastmod: 2023-10-09T17:25:45+09:00
waight: 9000
---

>PHP は、ほとんど全てが式であるという意味で、式指向の言語です。

## phpをインストールする

```sh
sudo apt-get install software-properties-common
# PPAを有効化
sudo add-apt-repository ppa:ondrej/php 
# PHP8以降が検索できるようになってる
sudo apt search php8.0-*
```

[php.ini ディレクティブのリスト](https://www.php.net/manual/ja/ini.list.php)

## Composerのインストール

<https://getcomposer.org/download/>

## 仕様

[PHP の PSR-0 と PSR-4 で autoloader の違いと名前空間の基礎](https://qiita.com/KEINOS/items/2924ecde3e4bab0ead7e)

## declare文

宣言以降のブロックの挙動を指定できる。`ticks`,`encoding`, `strict_types`が利用できる。  
ticksだと、宣言した実行単位で、低レイヤーでイベントが発生するようになる。（式単位かな）そのイベントの間隔で任意の処理を挟むことができる。

```php
static $i = 1;
$hoge = function () use (&$i) {
  $i++;
};
register_tick_function($hoge);
declare (ticks=2) {
  echo $i;
  echo $i;// この後に$hogeが動作する
  echo $i;
  echo $i;
  echo $i;
  echo $i;
}
unregister_tick_function($hoge);
```

[補足-declare-ticks-1-とマルチプロセス](https://ackintosh.github.io/blog/2018/08/17/not-all-statements-are-tickable/#補足-declare-ticks-1-とマルチプロセス)

### requireとincludeの挙動の違い

ファイル読み込みの失敗時の挙動が異なる。

- require
  - 致命的なエラーとなる
- include
  - 警告となるが、処理は継続される
  - 戻り値に読み込みの成否、もしくはreturnされた値が設定される

[PHPのinclude文とrequire文の違い](https://uxmilk.jp/15560)

### オートローディング

オートローダを登録することで明示的にクラスやインターフェースをincludeしていなくても、動的にクラスをロードする。

```php:example.php
class ClassLoader
{
  protected $dirs;

  /**
    * 登録したディレクトリをもとにオートローダにロードする関数を登録する
    */
  public function register()
  {
    spl_autoload_register(function (string $class) {
      foreach ($this->dirs as $dir) {
        $file = $dir. '/' . strtolower($class) . '.php';
        if (is_readable($file)) {
          include $file;
          return;
        }
      }
    });
  }

  /**
    * クラスファイルが格納されているディレクトリを登録
    *  @param string $dir ディレクトリ
    */
  public function registerDir(string $dir)
  {
    $this->dirs[] = $dir;
  }
}
```

### stdClass

オブジェクトでない型をオブジェクトに変換したときに変換されるメンバやメソッドを持たない標準クラス。  
[PHP: オブジェクト - Manual](https://www.php.net/manual/ja/language.types.object.php#language.types.object.casting)

## 疑問

Q. yield fromっていつ使うの  
Q. エラーハンドリング  
php.iniでエラーの挙動の設定ができる

- error_reporting
  - エラー出力レベルを設定します。
- display_errors
  - エラーをHTML出力の一部として画面に出力するかどうかを定義します。
  - デフォルト：stdout
- log_errors
  - エラーメッセージを、サーバーのエラーログまたはerror_logに記録するかどうかを指定 します。
  - error_log で定義した場所 (ファイルや syslog など) に書き出されます。

Q. thisの挙動  
Objectになると自身のクラスのオブジェクトがバインドされる。  
staticの場合、バインドされないので、staticじゃない関数とか呼ぶとthisにバインドされてなくてエラーになる。  

Q. UnitTestのベストプラクティス  
[PHPUnit](https://phpunit.readthedocs.io/ja/latest/index.html)をつかうらしい  
composer導入してLaravelと一緒でいいかな。  

Q. `file_get_contents`vs`cURL  

[APIなどにfile_get_contents()を使うのはオススメしない理由と代替案 - Qiita](https://qiita.com/shinkuFencer/items/d7546c8cbf3bbe86dab8)`

>file_get_contents() はヘッダ情報の保持ルールやタイムアウト処理に癖があるため
> 返却されるステータスコードや、タイムアウト時に再リクエストなどを行うような
> 対APIの処理では、それらを知らないと想定していない事態に陥る。

Q. cURLについて  
まんまPHPでcURLをたたける。ただのcURLなので、ヘッダーをパースしてくれたりとかは何もしてくれない。Do it yourself!!な感じ。  
これを使ったライブラリをcomposerで取得して使う感じかな。  

- [cURL - PHP プログラミング解説](https://so-zou.jp/web-app/tech/programming/php/network/curl/)
- [WebAPIを叩く(curl) - Qiita](https://qiita.com/re-24/items/bfdd533e5dacecd21a7a)

[php Reference](https://www.php.ne[t/manual/ja/langref.php)
