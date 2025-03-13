#!/bin/bash
set -e

cd ~

# Clone my dotfiles
if [ ! -d ~/dotfiles ]; then
  echo "Cloning dotfiles..."
  git clone git@github.com:riscait/dotfiles.git
else
  echo "dotfiles already cloned."
fi

# シンボリックファイルをホームディレクトリに作成する（https://zenn.dev/k4zu/articles/zsh-tutorial）
# 配置したい設定ファイルのリスト
dotfiles=(.zshrc .zprofile .zshenv .gitconfig)
for file in "${dotfiles[@]}"; do
  ln -svf ~/dotfiles/$file ~/
done

if [ "$(uname)" == 'Darwin' ]; then
  echo "Starting setup for macOS..."
  # スクリーンショットの撮影時に影を含めない
  defaults write com.apple.screencapture disable-shadow -bool true
  # Finderで隠しファイルを表示する
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # Xcodeでビルドにかかった時間を表示する
  defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true
  # シミュレータにタップジェスチャーを表示する
  defaults write com.apple.iphonesimulator ShowSingleTouches 1
  # USBやネットワークストレージに.DS_Storeファイルを作成しない
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # タップでクリック（1本指でタップ）
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 1

  # スペルの自動修正をOFFにする
  defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

  # Dock
  # に初期表示されているアプリをすべて削除
  defaults write com.apple.dock persistent-apps -array
  # 自動非表示ON
  defaults write com.apple.dock autohide -bool true
  killall Dock


  # プリファレンスのキャッシュ更新。これで反映されないなら再起動か再ログインを試す
  killall cfprefsd
  # SystemUIServerを再起動して設定を反映させる
  killall SystemUIServer

  if [ ! -f /usr/local/bin/brew ]; then
    # Homebrewをインストールする
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    source ~/.zshrc
    # Homebrewで管理しているパッケージをインストールする
    echo "Installing some software & library..."
    brew bundle --verbose --file="$HOME/dotfiles/Brewfile"
  else
    echo "Homebrew already installed."
  fi
else
  echo "The OS of this device is not macOS."
fi
echo "All processes have been completed. Reloading .zshrc and exiting."
source ~/.zshrc
