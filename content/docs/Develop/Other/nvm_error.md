---
title: nvmでなんかエラーでる
type: docs
author: showa
lastmod: 2023-10-09T04:24:51+09:00
waight: 1
---


```bash
nvm is not compatible with the npm config "prefix" option: currently set to "/home/shoma/.nodenv/versions/14.9.0"
Run `npm config delete prefix` or `nvm use --delete-prefix v14.16.0 --silent` to unset it.
shoma:~/dev/study/deno/practice$ npm config delete prefix
```

bash起動時にエラーがでてくる悲しみ。  
<https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally>  
<https://tutorialmore.com/questions-1118117.htm>  

この辺のことをやればできた。  
`npm confi set prefix`でnpmのバージョンを指定する  
`npm config set prefix $NVM_DIR/versions/node/v14.16.0`  

理由としてはこれらしいけどよくわからん。  
<https://www.webprofessional.jp/beginners-guide-node-package-manager/>  

npmでグローバルなところにファイルを置く場合、root権限を保つ必要がある。
なので、いちいちsudoしてあげないといけないけど、それは問題あるべ。  

グローバルなパッケージをインストールする場合のパーミッションの問題を回避するために、デフォルトのディレクトリを自分の権限があるディレクトリに変えてあげることでroot権限が不要になる。なので、これを変更してあげるためにprefixの変更をおこなって解決する。  
