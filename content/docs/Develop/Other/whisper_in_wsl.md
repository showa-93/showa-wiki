---
title: WSLでwhisper_micを動かす
type: docs
author: showa
lastmod: 2023-10-09T04:49:53+09:00
waight: 1
---

whisperをつかってリアルタイムの音声の書き起こしをするやつを動かす。  
これ↓
[マイクに話しかけた言葉を，リアルタイムにAIが認識（whisper, whisper_mic, Python を使用）（Windows 上）](https://www.kkaneko.jp/ai/repot/micrecog.html)  

```sh:install.sh
sudo apt install -y portaudio19-dev python3-pyaudio
sudo apt install -y ffmpeg

gh repo clone mallorbc/whisper_mic
cd whisper_mic
# python --version
# 3.10.10
pip install -r requirements.txt
python -m pip install click
python -m pip install pyaudio
```

```cmd
# Windows側でpulseaudio起動する
.\pulseaudio.exe
```

```sh:start.sh
# うちのGPUではsmallが限界。
python mic.py --model small
```

※WSL2でマイク入力をさせる  

- [Enabling sound in WSL | Memorandum!](https://ktkr3d.github.io/2020/08/01/Enabling-sound-in-WSL/)
- [PulseAudioをコマンドラインで操作したときのメモ - Qiita](https://qiita.com/msk_colo/items/e8db75f23b4499c5b945)
- [WSL2で libcuda.so: cannot open shared object fileになる - Qiita](https://qiita.com/cacaoMath/items/811146342946cdde5b83)

## 感想

WSLでマイク入力させるのがたいへんだった。pulseaudioさえ設定すればwsl2側は**wslgが有効なら**適当に設定で問題なかった。（PULSESERVERのIP設定いらん。）  
あとは音声入力をlistenするときにphrase_time_limitを設定してあげないと永遠に待ちに入ってしまうのはよくわからん。ローカルで動かす分にはぼちぼち読み取ってくれるけど、実用できるかというと微妙。largeとか動かせるGPUがあれば精度いいのかな。  
あと、何も言ってないと「ご視聴ありがとうございました。」が無限にでてくるのこわい。次回はおいしい食べ物紹介される…。  

![ご視聴ありがとうございました](https://scrapbox.io/files/642b020ba5b781001b36189c.png)
