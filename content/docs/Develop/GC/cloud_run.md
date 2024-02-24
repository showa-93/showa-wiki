---
title: Cloud Run
type: docs
author: showa
lastmod: 2024-02-24T04:30:49+09:00
waight: 1
---

## VPCのアクセス

- [よくわかる Cloud Run の VPC 接続の基本](https://zenn.dev/google_cloud_jp/articles/cloudrun-vpc)
- [ダイレクト VPC 下り（外向き）と VPC コネクタの比較  |  Cloud Run のドキュメント  |  Google Cloud](https://cloud.google.com/run/docs/configuring/connecting-vpc?hl=ja)

### 下り（外向き）

#### サーバーレスVPCアクセス

サーバーレス環境で**サーバーレスVPCアクセスコネクタ**経由で内部DNSと内部IPアドレスを使用してVPCネットワークにリクエストの送信とレスポンスの受信ができる。  
反対に他の内部トラフィックをサーバーレス環境に送信する方法については、**限定公開のGoogleアクセス**を利用する必要がある。  

コネクタの IP アドレス範囲を設定するには、次の 2 つの方法がある。  

- サブネットを使用するリソースがない場合は、既存の /28 サブネットを指定できる
- 未使用の /28 CIDR 範囲を指定できる

サーバーレス VPC アクセス コネクタは、コネクタ インスタンスで構成されており、マシンタイプが大きいほどスループットが高くなる。  

- [サーバーレス VPC アクセス  |  Google Cloud](https://cloud.google.com/vpc/docs/serverless-vpc-access?hl=ja)

#### ダイレクトVPC

ダイレクトVPCを利用するとサーバーレスVPCアクセスコネクタを使用せずにCloud RunがVPCネットワークに直接トラフィックを送信できる。  
また、インスタンスを使用しないためアクセス自体に必要な費用がネットワークの費用だけになる。  

ダイレクトVPCで利用すると各インスタンスにサブネット内のIPアドレスが割り当てられるため、サブネット内には十分なIPアドレスが使用可能な状態である必要がある。また、トラフィックが急増したときに備えて事前にIPが割り振られるため、存在するインスタンス数よりも多くなることも留意する。  
そのほか制限事項がいくつか存在するため、ドキュメントを参照。  

ダイレクトVPCを有効にするとVPC内にCloud Runインスタンスが立ち上がるようになり、Cloud RunからVPC内部のサービスへのリクエストは許可される。一方でVPCのほかのサービスからのCloud Runのインスタンスへのアクセスはできない。  
ダイレクトVPCを利用しても、通常通りCloud RunのエンドポイントへのリクエストはCloud Runにルーティングされる。（ここの制御は`上り（内向き）の制御`でする。）  

- [VPC ネットワークによるダイレクト VPC 下り（外向き）  |  Cloud Run のドキュメント  |  Google Cloud](https://cloud.google.com/run/docs/configuring/vpc-direct-vpc?hl=ja)
- [Cloud Run でダイレクト VPC 下り（外向き）の提供を開始: パフォーマンス向上と費用削減を実現 | Google Cloud 公式ブログ](https://cloud.google.com/blog/ja/products/serverless/announcing-direct-vpc-egress-for-cloud-run)

### 上り（内向き）

デフォルトの設定では、Cloud Runに設定されたドメイン(`run.app`またはカスタムドメイン)にインターネット経由でアクセスができる。  
上りの設定でこれらのアクセスの制限をかけることができる。  

- 内部  
  以下のソースからのリクエストを許可する。`ron.app`にアクセスする場合でもGoogleのネットワーク内に閉じる。ほかのソースからのリクエストは到達できない。  
  Cloud Runなどのサーバレスサービスからのリクエストを内部リクエストとみなすためにはVPCネットワークを経由する必要がある。  
  → [限定公開の Google アクセスを構成する  |  VPC  |  Google Cloud](https://cloud.google.com/vpc/docs/configure-private-google-access?hl=ja)
  - 内部アプリケーション ロードバランサ
  - VPC Service Controlsの境界内
  - Cloud Runと同じプロジェクトまたはVPC Service Controlsの境界内にあるVPCネットワーク
  - 共有VPC
  - 特定のGoogle Cloudのプロダクト
- すべて  
  インターネットから直接`run.app`へ送信されるリクエストを許可する

- [Cloud Run での上り（内向き）の制限  |  Cloud Run のドキュメント  |  Google Cloud](https://cloud.google.com/run/docs/securing/ingress?hl=ja)

#### 内部に設定されたCloud Runにアクセス

内部に設定されたCloud Runにアクセスするには、前述より内部のリクエストにする必要がある。  
Cloud Run → Cloud Runにアクセスする場合について考える。

1. 内部かつダイレクトVPCのCloud Runにリクエスト

- サーバーレスVPCアクセス経由  
  この場合、`すべてのトラフィックをVPCにルーティング`すると内部のリクエストとしてCloud Runに送信される。  
  一方でプライベートIPのみの場合、Cloud Runにインターネット経由でアクセスするためアクセスできない。  
- ダイレクトVPC経由  
  サーバーレスVPCアクセスでは有効だった`すべてのトラフィックを VPC にルーティング`に設定してもアクセスができない。  
  これはダイレクトVPC内にCloud Runを配置すると`VPCのほかのサービスからのCloud Runのインスタンスへのアクセスはできない`という制約があるためだと考えられる。  
  そのためダイレクトVPCに設定する場合、必ず限定公開のGoogeleアクセスの設定が必要になる。設定するとちゃんとできる。  

`プライベート IP へのリクエストのみを VPC にルーティングする`の設定のままルーティングさせたい場合は、ドキュメントに記載されたPVCまたは内部ロードバランサーを設定しDNSでそっちを見るようにするか、限定公開のGoogleアクセスを有効にしてDNSを設定するの２通りにのどちらかを選択する必要がある。  

- 限定公開のGoogeleアクセスとCloud DNSを利用した方法  
[![Image from Gyazo](https://i.gyazo.com/62bf6a6fe98ffc41f8c0fdcc15fb9a8e.png)](https://gyazo.com/62bf6a6fe98ffc41f8c0fdcc15fb9a8e)  
[![Image from Gyazo](https://i.gyazo.com/1437a21c327c39286ca6a284f75eed68.png)](https://gyazo.com/1437a21c327c39286ca6a284f75eed68)  
[![Image from Gyazo](https://i.gyazo.com/bab1492c4cb8b43e0c8b355408140f5e.png)](https://gyazo.com/bab1492c4cb8b43e0c8b355408140f5e)  
[![Image from Gyazo](https://i.gyazo.com/a8a23dddcaf72591f496d75bfc1a442d.png)](https://gyazo.com/a8a23dddcaf72591f496d75bfc1a442d)  

- [プライベート ネットワークと Cloud Run  |  Cloud Run のドキュメント  |  Google Cloud](https://cloud.google.com/run/docs/securing/private-networking?hl=ja#from-other-services)
- [Cloud Run から内向きが「内部」なCloud Run にアクセスしたい](https://zenn.dev/commmune/articles/fa6499f0fad2b3)
