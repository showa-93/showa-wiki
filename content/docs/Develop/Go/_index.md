---
title: Go
type: docs
weight: 6000
lastmod: 2024-05-09T01:45:13+09:00
---

## Goのバージョンアップ

```bash
version=1.22.3 && \
wget https://golang.org/dl/go${version}.linux-amd64.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz && rm -r go${version}.linux-amd64.tar.gz
```
