#!/bin/sh
cd ~

# Clone my dotfiles
if [ ! -d ~/dotfiles ]
 then
  ssh-keygen -t ed25519
  pbcopy < ~/.ssh/id_ed25519.pub
  echo "公開鍵をGitHubに登録しましたか？"
  select yn in "Yes"; do
   case $yn in
    Yes ) break;;
   esac
  done

  echo "Cloning dotfiles..."
  git clone git@github.com:Riscait/dotfiles.git
  # シンボリックファイルをホームディレクトリに作成する（https://zenn.dev/k4zu/articles/zsh-tutorial）
  # 配置したい設定ファイルのリスト
  dotfiles=(.zshrc .zprofile)
  for file in "${dotfiles[@]}"; do
    ln -s ~dotriles/$file ~/$file
  done
 else
  echo "dotfiles already cloned."
fi

if [ "$(uname)" == 'Darwin' ]; then
  # Finderで隠しファイルを表示する
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # SystemUIServerを再起動して設定を反映させる
  killall SystemUIServer

  # Install Homebrew
  if [ ! -f /usr/local/bin/brew ]
  then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Install some software with Homebrew
    echo "Installing some software & library..."
    brew bundle -v --file=./dotfiles/Brewfile
  else
    echo "Homebrew already installed."
  fi
  source ~/.zshrc
fi
