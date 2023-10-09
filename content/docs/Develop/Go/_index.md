---
title: Go
type: docs
weight: 1
lastmod: 2023-10-09T03:45:24+09:00
---

## Goのバージョンアップ

```go
version=1.21.2 && \
wget https://golang.org/dl/go${version}.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz && rm -r go${version}.linux-amd64.tar.gz
```
