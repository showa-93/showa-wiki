---
title: 分離性
type: docs
author: showa
lastmod: 2023-10-09T17:19:26+09:00
waight: 1
---

同時に実行しても、それぞれのトランザクションを重なりなく順番に実行した場合と同じ結果になることを直列可能（serializable）であると呼びます。  
分離性は、この直列可能性を保証するものです。  

参考

- [トランザクションの分離性（isolation）の概要](https://qiita.com/immrshc/items/efc8cb31226da297c9b4#:~:text=%E8%A4%87%E6%95%B0%E3%81%AE%E3%83%88%E3%83%A9%E3%83%B3%E3%82%B6%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E5%90%8C%E6%99%82%E3%81%AB,%E3%81%97%E3%81%A6%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%BE%E3%81%99%E3%80%82)
- [トランザクション分離レベル - microsoft](https://docs.microsoft.com/ja-jp/sql/odbc/reference/develop-app/transaction-isolation-levels?view=sql-server-ver15)
