#!/bin/zsh

# Flutter SDKインストールスクリプト for macOS
# ====================================

# 終了時にクリーンアップを行う
trap cleanup EXIT

cleanup() {
    # 一時ディレクトリが存在すれば削除
    if [ -d "$TMP_DIR" ]; then
        echo "一時ディレクトリを削除しています..."
        rm -rf "$TMP_DIR"
    fi
}

# エラーが発生したら終了
set -e

echo "=== Flutter SDKインストールスクリプト ==="
echo "このスクリプトはmacOS用の最新の安定版Flutter SDKをインストールします"

# 公式ドキュメントにならい、ホームディレクトリにFlutterをインストールするディレクトリを作成
FLUTTER_PARENT_DIR="$HOME/development"
FLUTTER_SDK_DIR="$FLUTTER_PARENT_DIR/flutter"
TMP_DIR=$(mktemp -d)

# Homebrewがインストールされているか確認
if ! command -v brew &>/dev/null; then
    echo "Homebrewをインストールしています..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrewはすでにインストールされています"
fi

# Xcodesのインストール確認とインストール
if ! command -v xcodes &>/dev/null; then
    echo "xcodesをインストールしています..."
    brew install robotsandpencils/made/xcodes aria2
else
    echo "✅ Xcodesはすでにインストールされています"
fi

# xcode-selectが使えるか確認
# if ! xcode-select -p &>/dev/null; then
#     echo "xcode-selectが使用できません。最新の安定版Xcodeをインストールしています..."
#     xcodes install --latest aria2
#     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
#     sudo xcodebuild -runFirstLaunch
#     sudo xcodebuild -license accept
# else
#     echo "✅ xcode-selectはすでに使用可能です"
# fi

echo "最新のXcodeをインストールします"
xcodes install --latest aria2
sudo xcode-select --switch /Applications/Xcode-16.2.0.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license accept
xcodebuild -downloadPlatform iOS
echo "✅ Xcodeのインストールが完了しました"

# gitがインストールされているか確認
if ! command -v git &>/dev/null; then
    echo "gitをインストールしています..."
    brew install git
else
    echo "✅ gitはすでにインストールされています"
fi

# 既存のFlutterディレクトリが存在するか確認
if [ -d "$FLUTTER_SDK_DIR" ]; then
    echo "Flutter SDKはすでに $FLUTTER_SDK_DIR に存在します"
    read -p "上書きしますか？ (y/N): " OVERRIDE
    if [[ ! "$OVERRIDE" =~ ^[Yy]$ ]]; then
        echo "インストールをキャンセルしました"
        exit 0
    fi
    echo "既存のFlutter SDKを削除しています..."
    rm -rf "$FLUTTER_SDK_DIR"
fi

# Flutterの親ディレクトリが存在しない場合は作成
if [ ! -d "$FLUTTER_PARENT_DIR" ]; then
    echo "ディレクトリを作成しています: $FLUTTER_PARENT_DIR"
    mkdir -p "$FLUTTER_PARENT_DIR"
fi

echo "最新の安定版Flutter SDKをダウンロードしています..."
git clone -b stable https://github.com/flutter/flutter.git "$FLUTTER_SDK_DIR"

# PATH環境変数を更新
echo "環境変数を設定しています..."

# .zshenvファイルのパス
ZSHENV="$HOME/.zshenv"

# すでにflutterへのパスが.zshenvに追加されているか確認
if grep -q "export PATH=.*flutter/bin" "$ZSHENV"; then
    echo "✅ PATHはすでに設定されています"
else
    echo "PATHに Flutter/bin を追加しています..."
    echo '' >>"$ZSHENV"
    echo '# Flutter SDKのパス' >>"$ZSHENV"
    echo 'export PATH="$PATH:'$FLUTTER_SDK_DIR'/bin"' >>"$ZSHENV"
fi

# 環境変数を適用
source $ZSHENV

echo "Flutter SDKをプリコンパイルしています..."
"$FLUTTER_SDK_DIR/bin/flutter" precache

echo "Flutter doctorを実行して依存関係を確認しています..."
"$FLUTTER_SDK_DIR/bin/flutter" doctor

# CocoaPodsのインストールを確認
if ! command -v pod &>/dev/null; then
    echo "CocoaPodsをインストールしています..."
    brew install cocoapods
else
    echo "✅ CocoaPodsはすでにインストールされています"
fi

echo ""
echo "=== Flutter SDKのインストールが完了しました ==="
echo "Flutter SDK場所: $FLUTTER_SDK_DIR"
echo ""
echo "次のステップ:"
echo "1. 'flutter doctor -v' を実行して、残りの依存関係を確認し、すべてのチェックマークが付いていることを確認してください"
echo ""
echo "Happy Flutter Coding!"
