#!/bin/sh

# シンボリックファイルを作成する
# https://zenn.dev/k4zu/articles/zsh-tutorial
# 配置したい設定ファイル
dotfiles=(.zshrc .zprofile)

# .zshrc という設定ファイルのシンボリックリンクを
# ホームディレクトリ直下に作成する
for file in "${dotfiles[@]}"; do
        ln -svf $file ~/
done
