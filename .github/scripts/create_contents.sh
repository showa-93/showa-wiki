#!/bin/bash

# 日本語のエンコード対策
git config --global core.quotepath false

# gistのIDとディレクトリを受け取る
# $1 = ec10db8e4fdd60148e6acd61641b9192
# $2 = docs/Develop
if [ $# -ne 2 ]; then
  echo 引数でgistのIDとディレクトリのパスを指定してください。
  exit 1
fi

# Gistをクローンしてscript終了時に削除するようにハンドリング
git clone https://gist.github.com/${1}.git docs
cleanup() {
  rm -rf docs
}
trap cleanup EXIT

# ファイル内の日時をGitの更新日時に変更する
(
  cd docs
  for file in $(git ls-files); do
    time=$(git log --pretty=format:%ci -n1 ${file})
    stamp=$(date -d "${time}" +"%Y-%m-%dT%H:%M:%S+09:00")
    sed -i -e "s/{{lastmod}}/${stamp}/" ${file}
  done
)

base_path="content/${2}/"
rm -rf ${base_path}*

for file in $(find ./docs -name '*.md'); do
  # ファイル名からディレクトリ名とファイル名の配列をつくる
  file_name=$(basename $file)
  tmp_file_name=${file_name//#/---}
  dirs=(${tmp_file_name//---/ })
  # 配列からパスを再構成する
  path="$(
    IFS=/
    echo "${dirs[*]}"
  )"
  dir_path=$(dirname $path)

  # ルートのファイルでない場合、mkdirでディレクトリをつくる
  if [ $dir_path != "." ]; then
    mkdir -p ${base_path}${dir_path}
  fi

  # !で始まるファイルはそのフォルダのindexファイルとして扱う
  file_name=$(basename ${path})
  if [[ $file_name == "!"* ]]; then
    file_name="_index.md"
  fi

  cp -p ${file} ${base_path}${dir_path}/${file_name}
done
