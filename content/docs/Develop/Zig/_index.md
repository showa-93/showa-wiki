---
title: Zig
type: docs
author: showa
lastmod: 2023-12-10T03:11:41+09:00
waight: 1
---

## Manual Install / Update

```bash
version="0.11.0"
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-${version}.tar.xz && sudo rm -rf /usr/local/zig && sudo mkdir /usr/local/zig && sudo tar -C /usr/local/zig -xvf zig-linux-x86_64-${version}.tar.xz --strip-components 1 && rm -r zig-linux-x86_64-${version}.tar.xz
wget https://github.com/zigtools/zls/releases/download/${version}/zls-x86_64-linux.tar.gz && sudo rm -rf /usr/local/zls && sudo mkdir /usr/local/zls && sudo tar -C /usr/local/zls -xzf zls-x86_64-linux.tar.gz --strip-components 1 && chmod +x /usr/local/zls/bin/zls && rm -r zls-x86_64-linux.tar.gz
```

## Language Server

[zigtools/zls: The @ziglang language server for all your Zig editor tooling needs, from autocomplete to goto-def!](https://github.com/zigtools/zls)

## Link

- [Zig Language Reference](https://ziglang.org/documentation/0.11.0/)
- [他言語習得者がとりあえず使えるようになるZig](https://zenn.dev/drumato/books/learn-zig-to-be-a-beginner)
