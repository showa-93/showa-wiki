---
title: EDNS0
type: docs
author: showa
lastmod: 2023-10-08T16:33:39+09:00
waight: 1
---

UDPの限界である512バイトを超える大きなメッセージを扱うことができる拡張方式。
DNSのフラグや応答コードの拡張もできる。ESN0の情報は疑似リソースレコードとして、Additionalセクションに格納される。

## IPフラグメンテーション

サイズの大きなIPパケットをより小さな最大転送単位（MTU）を持つネットワークを通る場合、MTUを超えるIPパケットはそれ以下に断片化されて転送される。
ファイアウォールの種類や設定によっては断片化されたパケットを通さないことがある。
IPv6における最小MTUの1280からヘッダーを除いた1232バイトや、DNSSECでサポートする最小値の1220バイトで設定することが多い。
