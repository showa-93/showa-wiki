---
title: QNAME minimisation
type: docs
author: showa
lastmod: 2023-10-09T04:32:21+09:00
waight: 1
---

（RFC 7816）  
問い合わせ情報の最小化。  
スタブリゾルバーから受け取った問い合わせをフルリゾルバーがそのままTLDの権威サーバーに問い合わせていた。
よって、TLDがクライアントの問い合わせ内容をしることができる。  
QNAME minimisationは、プライバシーの保護の観点から、レベルドメインごとの権威サーバーにNSを問い合わせ、スタブリゾルバーが問い合わせたドメイン名とタイプは該当の権威サーバーにのみ問い合わせるように名前解決アルゴリズムを変更する。  