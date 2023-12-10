---
title: Go
type: docs
weight: 6000
lastmod: 2023-12-10T01:52:56+09:00
---

## Goのバージョンアップ

```bash
version=1.21.5 && \
wget https://golang.org/dl/go${version}.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz && rm -r go${version}.linux-amd64.tar.gz
```
