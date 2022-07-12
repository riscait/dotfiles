#!/bin/sh
set -e

cd ~

# Clone my dotfiles
if [ ! -d ~/dotfiles ]
 then
  cd ~/.ssh
  ssh-keygen
  pbcopy < ~/.ssh/id_rsa.pub
  echo "公開鍵をGitHubに登録しましたか？"
  select yn in "Yes"; do
   case $yn in
    Yes ) break;;
   esac
  done

  echo "Cloning dotfiles..."
  git clone git@github.com:Riscait/dotfiles.git
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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    source ~/.zshrc
    # Install some software with Homebrew
    echo "Installing some software & library..."
    brew bundle -v --file=./dotfiles/Brewfile
  else
    echo "Homebrew already installed."
  fi
  source ~/.zshrc
fi
