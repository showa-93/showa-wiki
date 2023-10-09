---
title: VPNサーバーを立てる
type: docs
author: showa
lastmod: 2023-10-09T04:47:59+09:00
waight: 1
---

rasberry pi 3bにVPNサーバーを構築するぞい  

## Ubuntu Serverを導入

### imageの導入

<https://www.raspberrypi.org/software/>
なるよしなにイメージ作ってくれる便利ツールがrasberrypi公式から提供されているので、こいつを使ってSDカードにインストール！！！  
あとはrasberrypi で読み終わるのをまつ  

### ipの設定

とりあえずローカルIP固定にしてリモートでいじれるようにしたい  
ネットワークの設定でゲートウェイのIPみすってたのではまった  

<https://qiita.com/zen3/items/757f96cbe522a9ad397d#ip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%81%AE%E7%A2%BA%E8%AA%8D>  
<https://www.komee.org/entry/2018/06/12/181400>  

## userとかの設定

<https://qiita.com/quailDegu/items/63114ba1e14416df8040#ssh%E3%81%AE%E8%A8%AD%E5%AE%9A>  
だいたいこの辺にかいているやつをやる

```bash
# ユーザー追加
sudo adduser shoma
sudo adduser shoma sudo
# ユーザーlock

sudo passwd -d ubuntu # passwordの削除
sudo passwd -l ubuntu
sudo passwd -l root
```

```bash
# 鍵設定
ssh-keygen -t rsa -f hoge_rsa
ssh-copy-id -i ~/.ssh/id[/ rsa.pub ras]vpc # はじめてしった。便利。
```

```bash
# 日本語にしまっせ
sudo apt install language-pack-ja-base language-pack-ja ibus-mozc
sudo update-locale LANG=ja_JP.UTF-8
echo $LANG
date
```

## VPN Serverつっこむ

<https://my.noip.com/#!/account>  

no-ipにアカウントを作ってhostを取得する  
現在のIPを設定するDdclientをインストールする  
`sudo apt install ddclient -y`  

<https://deviceplus.jp/hobby/how-to-use-raspberry-pi-as-vpn-server/>  

PiVPNっていう簡単インストールツール君を使ってWireguardをインストールする  

つなげられるようにするのにかなりじかんがかかった  
原因は、アパートのルーターを使ってプライベートIPをふられているから、外にでようがなかった  
とりあえず、グローバルIPサービスってのに課金してIPをもらってみる（１０００円／月）  
→グローバルIPもらって設定したらできた。  

## 外形監視いれてみた

[mackerel](https://mackerel.io/ja/features/)っていうモニタリングサービスを導入してみた。hatena がやってるらしい。日本製なのでよい。  

サーバーにtoolいれてAPI key設定するだけでアプリケーションの登録ができちゃう  
`wget -q -O https://mackerel.io/file/script/setup-all-apt-v2.sh | MACKEREL_APIKEY='[API KEY]' sh`  

![hoge](https://scrapbox.io/files/60d1b9b8e38b85001cddef5f.png)
なんかそれっぽい！  
外形適当にcpuとメモリだけみてSlack通知するようにした。  
