---
title: Circuit Breakerパターン
type: docs
author: showa
lastmod: 2023-10-08T15:36:55+09:00
waight: 1
---

リモートコールで呼び出し先で障害が発生した場合、呼び出しに失敗したり、応答を待ち続けることになる。  
多くの呼び出しが発生した場合、リソース不足になり、連携している複数のシステムに連鎖的に障害が発生する可能性がある。  
Michael Nygard氏は、著書「Release It」の中でこのような問題を防ぐためにCircuit Breakerパターンを提唱した。  

リクエストの成否を数え、エラー率がしきい値を超過したらサーキットブレーカーを作動させ、その後一定の時間がすぎるまでリクエストを失敗させる。（障害が発生したサービスへのリクエストを遮断）  
一定の時間がすぎると、決められた数の試験的なリクエストをおこない、成功すればサーキットブレーカーは通常動作に戻る。失敗する場合は、再度リクエストを失敗させるタイムアウト期間に入る。  

**TODO**: パターンについてまとめる

- [CircuitBreaker - martinfowler.com](https://martinfowler.com/bliki/CircuitBreaker.html)
- [Circuit breaker - microservices.io](https://microservices.io/patterns/reliability/circuit-breaker.html)
- [sony/gobreaker](https://github.com/sony/gobreaker)
- [go-circuitbreakerのご紹介 - speakerdeck](https://speakerdeck.com/matope/mercari-dot-go-number-12-go-circuitbreakerfalsegoshao-jie)
