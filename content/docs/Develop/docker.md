---
title: Docker
type: docs
weight: 100700
---

## コンテナを実現する技術や標準

### LinuxBaseStandardとLinuxABI（ApplicationBinaryInterface）

Linuxディストリビューションやカーネルのバージョンが違っても動作する理由はいくつかあります。まず、LSB（LinuxStandardBase）はソースコードをコンパイルした時点で、互換性のあるマシンコードを生成するよう、ISO規格として標準化されています。また、LinuxABI（ApplicationBinaryInterface）には、Linuxカーネルのバージョンが上がっても、ユーザー空間で動作するバイナリ（マシンコード）レベルの互換性を維持することが定められています

### Linuxカーネル技術

- ネームスペース（Namespace）  
ネームスペースはLinuxのカーネル技術であり、コンテナが1つの独立したサーバーのように振る舞うために使用されます。
- コントロールグループ（cgroup）  
cgroupはプロセスに対して、CPU時間やメモリ使用量など、資源の監視と制限を設定することができます

### OCI（OpenContainerInitiative）

コンテナランタイムの標準仕様「RuntimeSpecificationv1.0」と、コンテナイメージフォーマットの標準仕様「FormatSpecificationv1.0」から成ります。このOCIの定めた標準仕様にしたがいDocker社が実装したのが、コンテナランタイムのrunCです。一方で、CoreOSのコンテナランタイムrktについても、ネイティブで標準に準拠するための作業が進んでいます。  

高良真穂.15Stepで習得Dockerから入るKubernetes(Kindleの位置No.909).株式会社リックテレコム.Kindle版.

## link

- [Dockerドキュメント](https://docs.docker.jp/index.html)
- [Dockernetwork概論](https://qiita.com/TsutomuNakamura/items/ed046ee21caca4a2ffd9)
- [.envでDocker開発環境をカスタマイズ！](https://zenn.dev/forcia_tech/articles/20230613_hatano_dotenv)
- [Linux環境でDockerコンテナ内にuserで入る](https://zenn.dev/temple_c_tech/articles/exec-container-by-user)
- [docker build battle - Speaker Deck](https://speakerdeck.com/orisano/docker-build-battle?slide=82)
  - いかにイメージのサイズを小さくし、速くするか
