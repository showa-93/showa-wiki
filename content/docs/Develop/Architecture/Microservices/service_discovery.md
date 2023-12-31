---
title: サービスディスカバリ
type: docs
author: showa
lastmod: 2023-10-09T14:45:11+09:00
waight: 1
---

サービスディスカバリメカニズムは、サービスインスタンスが起動・終了したときにサービスレジストリを更新する。クライアントがサービスを呼び出すと、サービスディスカバリメカニズムはサービスレジストリにクエリを送り、利用できるインスタンスの一覧を取得し、どれかにルーティングする。  

## アプリケーションレベルの実装パターン

サービスディスカバリとそのクライアントがサービスレジストリを操作する
アプリケーションレベルでサービスディレクトリが存在すると、プラットフォームをまたいでサービスが存在しても、処理できるというメリットがある。

- [Self registration パターン]( http://aws.clouddesignpattern.org/index.php/CDP:Self_Registrationパターン)
  - サービスインスタンスがサービスレジストリの登録APIを呼び出して自分のアドレスを登録する
- [Client-side discovery パターン](https://microservices.io/patterns/client-side-discovery.html)
  - クライアントがサービスレジストリからリストを取得し、クライアント自身でバランシングアルゴリズムを使ってサービスインスタンスを選択する

## プラットフォームが提供するパターン

DockerやKubernatesなどのデプロイプラットフォームは、組み込みでサービスがレジストリとディスカバリメカニズムを持っている。
プラットフォームが提供する最大の利点は、プラットフォームを利用する側が意識せずともサービスディスカバリを行ってくれるという点にある。また、サービスにもクライアントにもサービスディスカバリのためのコードが含まれなくなるため、言語やフレームワークに依存せずに利用ができる。

- [3rd party registration パターン](https://microservices.io/patterns/3rd-party-registration.html)
  - サービスがレジストリに登録するのではなく、サードパーティであるレジストラが登録処理をする
  - サービスのソースコードが影響を受けない。
  - また、サービスインスタンスにヘルスチェックをおこない、インスタンスの登録／登録解除を行える
- [Server-side discovery パターン](https://microservices.io/patterns/server-side-discovery.html)
  - クライアントでレジストリに問い合わせずに、DNS名をリクエストルーター（ロードバランサー）に送り、ルーターがサービスレジストリに問い合わせし、利用可能なサービスインスタンスにリクエストの転送を行う
  - AWS Elastic Load Balancerなどで提供されている
  - [https://scrapbox.io/files/60b78ce84b9ae5001cf91206.png]
