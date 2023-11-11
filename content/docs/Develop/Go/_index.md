---
title: Go
type: docs
weight: 6000
lastmod: 2023-11-11T04:45:35+09:00
---

## Goのバージョンアップ

```go
version=1.21.4 && \
wget https://golang.org/dl/go${version}.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz && rm -r go${version}.linux-amd64.tar.gz
```
