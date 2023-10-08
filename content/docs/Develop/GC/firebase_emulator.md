---
title: Firebase Emulator on Docker
type: docs
author: showa
lastmod: 2023-10-08T16:38:25+09:00
waight: 1
---

Docker上でFirebase Emulatorを動かす。備忘録。
ほぼ他所様のブログのまんま。権限の解決だけ追加でやってる。

- [docker で firebase emulator を起動する - MoguraDev](https://mogura.dev/articles/docker-firebase-emulator/)

Firebase Emulatorを動かすDockerfileの内容は以下の通り。  
cli-tableの不具合によって、firebase-toolsのv9.22.0で動作しなくなっていたため、暫定対処としてgithubからcloneして、cli-tableのバージョンをバグのないバージョンに固定している。が、11/18にマージされていて解決している。  
[Firebase Emulator throws npm cli-table error only when importing firestore data · Issue #3909 · firebase/firebase-tools](https://github.com/firebase/firebase-tools/issues/3909)

```docker:Dockerfile
FROM node:16-alpine
RUN apk add --no-cache openjdk11-jre-headless \
     && apk add shadow
#    && apk add shadow \
#    && apk add git

RUN npm i -g firebase-tools
#11/18に不具合対応がマージされてv9.23.0で解決
#cli-tableにバグがあり、暫定対応のために
#firebase-toolsのcli-tableのバージョンを固定してbuildしている
#RUN mkdir tools && cd tools \
#    && git clone https://github.com/firebase/firebase-tools.git -b v9.22.0 \
#    && cd firebase-tools \
#    && npm install -g npm \
#    && npm config set save-exact true \
#    && npm install cli-table@0.3.6 \
#    && npm install \
#    && npm run build \
#    && npm link

RUN groupmod -g 1000 node && usermod -u 1000 -g 1000 node
USER node
```

以下Docker Composeのファイル。  
ホスト側のfirebaseのキャッシュや設定を直接読み取って起動している。  
ただ、ホスト側でemulatorを起動していると、権限が異なるためPermission deniedになる。  
これを回避するために、ホスト側と同じグループのユーザーをDockerfileで設定している。  

```yaml:docker-compose.yaml
 version: '3'

 services:
   firebase:
     build:
       context: .
       dockerfile: firebase/Dockerfile
     tty: true
     restart: always
     command: firebase emulators:start --only auth,firestore --export-on-exit ./firebase/.firebase --import ./firebase/.firebase
     ports:
       - "9000:9000"
       - "8080:8080"
       - "9099:9099"
     volumes:
       - .:/workspace
       - ~/.cache/firebase:/root/.cache/firebase
       - ~/.config/configstore:/root/.config/configstore
     working_dir: /workspace
 
```

権限周りなんもわからん
