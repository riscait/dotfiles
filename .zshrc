# Zshの補完機能を初期化 (Completionで使用する)
autoload -Uz compinit
compinit

# Melos
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Android Debug Bridge
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# direnv
export EDITOR=vi
eval "$(direnv hook $SHELL)"

# rbenv（Rubyは単一バージョンの使用で耐えるか試験中）
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# Ruby by Homebrew（MacのデフォルトRutyではバージョンが低すぎる）
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# gpg
export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/riscait/.dart-cli-completion/zsh-config.zsh ]] && . /Users/riscait/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# GitHub CLI
eval "$(gh completion -s zsh)"

# Go
export PATH="$HOME/go/bin:$PATH"

# Git alias
alias gpro="git pull --rebase origin"
alias gpfwl="git push --force-with-lease"

# Misc alias
alias sed="gsed"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riscait/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riscait/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riscait/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riscait/google-cloud-sdk/completion.zsh.inc'; fi

## Java Home
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Bun
export PATH="$HOME/.bun/bin:$PATH"
