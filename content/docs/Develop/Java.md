---
title: Java
type: docs
author: showa
lastmod: 2023-10-09T04:02:02+09:00
waight: 1
---

- [Java7からJava16までの変遷。 - Qiita](https://qiita.com/sivertigo/items/8f61f02f7c84b786697a)
- finalについて
  - [Javaのfinalを大解剖 finalの全てがここにある!!](https://www.bold.ne.jp/engineer-club/java-final)
    - 完全に理解した
- JavaBeans
  - 再利用可能なモジュール化されたプログラムを作成するための仕様
  - [(Java)新人向けにJavaBeansの直列化やフィールド・プロパティの謎をPOJOとの違いを交えて解説 - Qiita](https://qiita.com/ukitiyan/items/3b7f1ea7eb3d208ed5fe#結局のところjavabeansとは)
- 非同期処理
  - `Thread` で非同期処理をおこなう別のスレッドを動かせる
  - 「`Thread`の継承したクラス」または「Runnable を実装したクラス」を実行体として利用できる
  - [Javaのスレッド(Thread)を使いこなすコツを、基礎からしっかり伝授](https://www.bold.ne.jp/engineer-club/java-thread)
  - Callbackや共通の変数で値の受け渡しをおこなう。
- 排他制御
  - `synchronized` ブロック
    - 識別子で指定したブロックそのものを排他制御させる。マルチスレッドで同時に実行されることを防げる
    - ロック対象は同一のインスタンスのみ
  - `synchronized`識別子
    - メソッドそのものを排他制御させる。マルチスレッドで同時に実行されることを防げる
  - `ReentrantLock`クラス
    - 明示的にロック制御可能
    - lock取得後try-catchで囲んで、finallyで必ずロックを開放する
  - `atomicなんたら`
    - 単一の変数などの加算代入などの原子性を担保して排他制御できる
- ラムダ式やメソッドの参照に利用するインターフェースたち
  - <https://docs.oracle.com/javase/jp/8/docs/api/java/util/function/package-summary.html>
- `Stream`
  - Collectionの操作を遅延評価で行う専用のオブジェクト
  - 拡張性を考慮された結果、Listに直接生やすのではなく、一度stream()を挟む形になっているらしい、
  - <https://qiita.com/huge-book-storage/items/79fe8bd0de330e9ed1f7>

## Gradle

- gradlew
  - Gradle Wrapperのコマンド
  - 共通の設定済みのGradleを配布できる形にしたもの
  - `gradle wrapper`
  - `gradlew dependencies`
    - 依存関係にあるライブラリをダウンロードする
  - `gradle bootBuildImage`
    - イメージを作成する
    - <https://spring.pleiades.io/spring-boot/docs/current/gradle-plugin/reference/htmlsingle/#build-image>
- build.gradle
  - groovyで記述できるビルド定義
  - dependencies
    - ビルド時に必要なライブラリを定義している
    - [Gradleのdependenciesはどう書くべきか | Korean-Man in Tokyo](https://retheviper.github.io/gradle/2019/11/04/gradle-dependencies/)  

    ```gradle:build.gradle
    dependencies {
      implementation 'org.groovy:groovy:2.2.0@jar'
      implementation group: 'org.groovy', name: 'groovy', version: '2.2.0', ext: 'jar'
    }
    ```

## Spring Boot

実行可能なスタンドアロンのSpringベースのアプリケーションを作成できるフレームワーク。
デフォルトのロギングシステムはlogbackが利用されている→[Spring Boot でロギングライブラリをLog4j2にする - Qiita](https://qiita.com/kazokmr/items/7d8323cd2033b233c261)
<https://spring.pleiades.io/spring-framework/docs/current/reference/html/>

- SpringのDIコンテナーの読み込み
`@ComponentScan`(`@SpringBootApplication`)のアノテーションがついているクラスのパッケージとその配下のクラスに存在する`@Component`（またはそれが含まれるアノテーション）がついているクラスを走査し、BeanをDIコンテナに登録する。
<https://github.com/kazuki43zoo/spring-study/tree/master/memos/ioc-container>

### アノテーション

- Bean
  - Springコンテナで管理させたいBean（オブジェクト）を生成するメソッドにつける
  - `@Configuration`をつけたクラスで定義できる
  - Springコンテナによってインスタンス化され、`@Autowired`または`@Inject`を付与したフィールドにDIされる
  - Java Beansと異なり`Java.io.Serializable`を実装する必要がない
  - サードパーティライブラリのクラスを利用する場合に利用することが多い
    - <https://stackoverflow.com/questions/10604298/spring-component-versus-bean>
  - [【Spring】Beanのライフサイクル〜生成から破棄まで〜 - Qiita](https://qiita.com/kawakawaryuryu/items/c7d71fd56c497e283198)
  - Beanを生成、破棄するFactoryのインターフェース
    - <https://spring.pleiades.io/spring-framework/docs/5.3.9/javadoc-api/org/springframework/beans/factory/BeanFactory.html>
- Component
  - SpringのDIコンテナで管理させ、`@Autowire`などでDIできるようになる
- ComponentScan
  - このクラスのパッケージ配下で@Component, @Service, @Repository, @Controller, @RestController, @Configuration,@NamedつきのクラスをDIコンテナに登録します。
- RestControllerAdvice
  - 共通のエラーハンドリングのクラスを表す
    - 各メソッドに`@ExceptionHandler`でハンドリングする例外を指定することで例外別のエラー処理を作成できる
    - `@ExceptionHandler`は通常のコントローラ内のメソッドでアノテーションを指定するとコントローラ別で例外処理できる
  - [Spring-boot-exception-handling - Dev Guides](https://www.finddevguides.com/Spring-boot-exception-handling)
  - [アドバイスの作成3 - ＠ControllerAdvice · 独習Spring](https://yo1000.gitbooks.io/self-study-spring/content/chapter10.html)

## Lombok

アノテーションをつけることでコンパイル時にコードを自動生成するライブラリ
同一のコードを記載することで発生する煩雑さをなくし、コードの可読性を向上させられる

- [(Java)Lombokを使って等価性の対象フィールドを制御する | DevelopersIO](https://dev.classmethod.jp/articles/lombok-excludes-fields-from-object-equality/)

## SLF4J

使いたいロギングライブラリをプラグインできるようにするファサード。
SLF4J自体はロギングのインターフェースであり、このインターフェースに対応した実装のロギングシステムを設定で切り替えられる。
共通のインターフェースでロギングライブラリの詳細を知らずとも利用でき、インターフェースが共通なため他のライブラリに切り替えることも容易。

- [SLF4Jとはなにか - 理系学生日記](https://kiririmode.hatenablog.jp/entry/20150526/1432625055)
- [SLF4J、Logback、Log4Jの関係を挙動とともに整理する - Qiita](https://qiita.com/NagaokaKenichi/items/9febd2e559331152fcf8)

## Q&A

- ビルドツールの違いって何？
  - [ビルドツール make / ant / maven / gradle ざっくり理解メモ - Qiita](https://qiita.com/MahoTakara/items/ff73338e218b656bedfa)
  - Maven
  - Gradle
- サーブレットコンテナってなに
  - Java Servletの実行環境。Webコンテナとも呼ばれる
    - Tomcat
    - Jetty
  - Webサーバー→サーブレットコンテナ→サーブレット
  - ビジネスロジック以外の処理を提供してくれたりする
  - Spring Bootの場合、TomCatかなんかがくみこまれてる
- Spring Bootビルド後のコントローラってどうなってるの。というかルーターの生成かな。
  - Spring boot側が管理してるけど、最初のロードのときにやってんのかな
- WebサーバーとSpring bootとかの関係性（通信経路）がぴんとこん
  - spring bootは、tomcatが同梱された実行ファイルを生成するぜ
  - なので、spring bootで開発したらそのまま動かせる
  - [さくっと理解するSpring bootの仕組み](https://www.slideshare.net/OgawaTakeshi/spring-boot-71285225)
- エラーハンドリングってどうしてるの
  - 一番大本のエラーハンドリングするコントローラがつくれるからそこで任意の例外を補足するか、個別で補足するか
