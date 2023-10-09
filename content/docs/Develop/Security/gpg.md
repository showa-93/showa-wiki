---
title: GPG
type: docs
author: showa
lastmod: 2023-10-09T03:50:20+09:00
waight: 1
---


- [1. 公開鍵暗号とGPGの基本](https://lecture.ecc.u-tokyo.ac.jp/johzu/joho/Y2022/GPG/GPG/gpg_1.html)
- [第675回　apt-keyはなぜ廃止予定となったのか | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0675)
- [Dockerfile: 非推奨化されたapt-keyを置き換える｜TechRacho by BPS株式会社](https://techracho.bpsinc.jp/hachi8833/2022_01_11/114803)

apt-keyの代替

```sh:key.sh
curl -sSL キー取得元URL | gpg --dearmor -o /usr/share/keyrings/パッケージ名.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=キー取得元URL] debパッケージ取得元URL" オプション | tee /etc/apt/sources.list.d/パッケージ名.list > /dev/null
```
