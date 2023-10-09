---
title: ChatGPT
type: docs
author: showa
lastmod: 2023-10-09T17:26:50+09:00
waight: 100200
---

## プロンプト

プロンプトエンジニアリングで可能な例やアプリケーションをさらに多く取り上げるにつれて、プロンプトを構成する特定の要素があることに気付くでしょう。プロンプトには、以下のコンポーネントが含まれます。

- **指示** - モデルに実行してほしい特定のタスクや指示
  - 「書く」「分類する」「要約する」「翻訳する」「並べ替える」など、モデルに目的を達成させるよう指示するコマンドを使って、さまざまなシンプルなタスクに効果的なプロンプトを設計することができます。
  - 指示と文脈を区切るために、「###」のような明確なセパレータを使用することもお勧めされています。
  - プロンプトが詳細で説明的であればあるほど、結果は良くなります。
  - プロンプトを設計する際には、具体的で直接的であることが重要です。
  - やらないことを言うのではなく、代わりにやることを言う。
- **文脈** - 外部情報や追加の文脈を含めることで、モデルがより良い回答に導かれる
- **入力データ** - 応答を見つけたい入力や質問
- **出力指標** - 出力のタイプや形式を示す。

より良い結果を得るためのプロンプトの改善させる概念

- **Zero-Shot Prompting**
  - 大量に訓練され調整されたLLMは、命令だけ（ゼロショット）でタスクを実行できる
- **Few-Shot Prompting**
  - より複雑なタスクではゼロショットでは不十分。プロンプトの中でデモンストレーション（例を示す）をおこなうことでモデルの性能を向上させることができる。数発のプロンプトで文脈を使って学習させることができる。
    - デモンストレーションで示す入力と結果の分布はどちらも重要
    - 一様な分布じゃなく、ランダムな分布でもない場合より有効
    - 本当の分布に合わせた分布でデモンストレーションすることでさらなる学習の助けになる
  - 推論問題に対してはfew-shotでは不十分。
- **Chain-of-Thought Prompting**（CoT）
  
[dair-ai/Prompt-Engineering-Guide: Guides, papers, lecture, and resources for prompt engineering](https://github.com/dair-ai/Prompt-Engineering-Guide)の抜粋

## 参考

- [ChatGPTは馬鹿じゃない！ 真の実力を解放するプロンプトエンジニアリングの最前線](https://zenn.dev/noritamarino/articles/a2321a65fe2be8)
- [Prompt Engineering: The Ultimate Guide 2023 (GPT-3 & ChatGPT)](https://businessolution.org/prompt-engineering/)
- [LLMがなぜ大事なのか?経営者の視点で考える波の待ち受け方｜福島良典 | LayerX](https://comemo.nikkei.com/n/nf3132b57539c)
- [大規模言語モデル(LLM)の快進撃](https://www.google.com/amp/s/www.axion.zone/423987504861/amp/)
- [自然言語処理AIとの接近 – りん研究室](https://www.con3.com/rinlab/?p=6233)
- [GPTの仕組みと限界についての考察（１） - conceptualization](https://isobe324649.hatenablog.com/entry/2023/03/20/215000)
- [深層学習界の大前提Transformerの論文解説！ - Qiita](https://qiita.com/omiita/items/07e69aef6c156d23c538)
- [数式を使わないTransformerの解説（前編） - conceptualization](https://isobe324649.hatenablog.com/entry/2022/08/20/212110)
- [Transformer モデルとは? | NVIDIA](https://blogs.nvidia.co.jp/2022/04/13/what-is-a-transformer-model/)
- [【完全保存版】GPT を特定の目的に特化させて扱う (Fine-tuning, Prompt, Index, etc.) - Qiita](https://qiita.com/tmgauss/items/22c4e5e00282a23e569d)
