# showa-wiki

GistPadを使ってGistに保存したMarkdownを閲覧するためのWiki。  
Hugoのcontentsに作成したGistsをコピーしてGitHub Pagesにリリースする。  

```bash
# hugoのinstall
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
# themeのアップデート
 git submodule update --remote
```
