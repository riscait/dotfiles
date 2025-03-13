# use gnu sed
alias sed="gsed"

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

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# gpg
export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/riscait/.dart-cli-completion/zsh-config.zsh ]] && . /Users/riscait/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# GitHub CLI
eval "$(gh completion -s zsh)"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# 1Password SSH key
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Go
export PATH="$HOME/go/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riscait/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riscait/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riscait/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riscait/google-cloud-sdk/completion.zsh.inc'; fi

# Git alias
alias gpro="git pull --rebase origin"
alias gpfwl="git push --force-with-lease"
