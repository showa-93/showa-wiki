---
title: faviconにカメラの映像をだす
type: docs
author: showa
lastmod: 2023-10-08T16:35:28+09:00
waight: 1
---

丸パクリ。[Web でカメラを使おう – WebRTC (getUserMedia) on WebView 芳和システムデザイン](https://houwa-js.co.jp/2019/06/20190604/)  
Denoでやることを諦めた。intervalが50ms以下だと書き込み不安定になるから動画ががたがたになる。  

<https://houwa-js.co.jp/exe/2019/06/20190604/>

```html
<html lang="ja">
  <head>
      <link id="favicon" rel="icon" href="">
  </head>
  <body>
      <video id="player" hidden="hidden" autoplay></video>
      <canvas id="snapshot" hidden="hidden" width="640" height="640"></canvas>
      <script>
          let player = document.getElementById('player')
          let snapshotCanvas = document.getElementById('snapshot')
          let width = snapshotCanvas.width
          let height = snapshotCanvas.height
          const elm = document.getElementById('favicon')
          let startScan = function() {
              let intervalHandler = setInterval(() => {
                  snapshotCanvas.getContext("2d").drawImage(player, 0, 0, width, height)
                  const imageDataBlob = snapshotCanvas.toBlob(function(blob){
                      const url = URL.createObjectURL(blob)
                      elm.setAttribute('href', url)
                  });
              }, 50)
          };
          let handleSuccess = function(stream) {
              player.srcObject = stream;
              startScan()
          };
          navigator.mediaDevices.getUserMedia({
              video: {facingMode: "environment", width: width, height: height},
              audio: false
          }).then(handleSuccess)
          .catch(err => {
              console.log(JSON.stringify(err));
          });
      </script>
  </body>
</html>
```
