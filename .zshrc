# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Flutter
# FVM (Flutter Version Management)
export PATH="$PATH:$HOME/.pub-cache/bin"
# fvm globalを使用するのに必要なPATH
export PATH="$PATH:$HOME/fvm/default/bin"
alias f="fvm flutter"
alias d="fvm dart"
alias m="fvm flutter pub global run melos"

# Android Debug Bridge
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# direnv
export EDITOR=vi
eval "$(direnv hook $SHELL)"

# rbenv
eval "$(rbenv init -)"

# gpg
export GPG_TTY=`tty`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

