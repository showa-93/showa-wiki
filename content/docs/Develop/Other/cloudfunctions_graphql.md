---
title: Cloud FunctionsでGraphQLを動かす
type: docs
author: showa
lastmod: 2023-10-08T15:45:05+09:00
waight: 1
---

[gqlgen](https://gqlgen.com)でイニシャライズする  

```bash
 go get github.com/99designs/gqlgen
 go run github.com/99designs/gqlgen init
```

直接ServeHttpを叩いて動かすようにしてみる

```go
 var srv *handler.Server
 var play http.HandlerFunc
 
 func init() {
  srv = handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{}}))
  // /GraphQLHandlerを含めないとplaygroundのアクセス先がおかしくなる
  play = playground.Handler("GraphQL playground", "/GraphQLHandler/query")
 }
 
 func GraphQLHandler(w http.ResponseWriter, r *http.Request) {
  switch r.RequestURI {
  case "/query":
   srv.ServeHTTP(w, r)
  case "/":
   play.ServeHTTP(w, r)
  }
 }
 
```

Cloud BuildのAPIを有効化して、cloud functions APIを許可する

```bash
 gcloud functions deploy graphql --runtime go116 --trigger-http
```

Deploy後のURLにアクセスしたらちゃんとPlayGroundが表示される  

![hoge](https://scrapbox.io/files/6183fa010298e3001d181930.png)  
