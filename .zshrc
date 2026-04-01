#######################################################
# User configuration
#######################################################

# SSHで接続した先で日本語が使えるようにする
# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/bin/vim

## バックグラウンドジョブが終了したらすぐに知らせる。
# setopt no_tify

# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 他のターミナルとヒストリーを共有
setopt share_history
# 重複を記録しない
setopt hist_ignore_dups
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# 補完時にヒストリを自動的に展開
setopt hist_expand

# 入力した文字から始まるコマンドを履歴から検索し、上下矢印で補完
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

## keybind
bindkey -e

# Other settings
export DOTFILES_PATH=$HOME/dotfiles
source "$DOTFILES_PATH/zsh/alias.zsh"
source "$DOTFILES_PATH/zsh/plugins.zsh"
source "$DOTFILES_PATH/zsh/functions.zsh"

#######################################################
# Tools
#######################################################
# starship
eval "$(starship init zsh)"

# visual studio code alias
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }

# asdf
. $(brew --prefix asdf)/libexec/asdf.sh

#入力補完
# zsh-completions
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#   fpath=(${ASDF_DIR}/completions $fpath)
#   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#   autoload -Uz compinit
#   compinit
# fi
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fpath=(~/.zsh/completion $fpath)

  ## 補完で小文字でも大文字にマッチさせる
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  ## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
  zstyle ':completion:*:default' menu select=1 

  autoload -Uz compinit
  compinit
fi

# go, goenvのパス
# export GOPATH="$HOME/go"
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
# export PATH="$PATH:$GOPATH/bin"
# asdfで管理しているすべてのバージョンのパスを通す
# for version in $(ls ~/.asdf/installs/golang); do
#     export PATH=$PATH:~/.asdf/installs/golang/$version/go/bin
# done
# GOPATH
# export GOPATH=$(go env GOPATH)
# export PATH=$PATH:$GOPATH/bin
. ~/.asdf/plugins/golang/set-env.zsh
export GOPATH="$(dirname "$(dirname "$(dirname "$(asdf which go)")")")/packages"
export GOBIN="$GOPATH/bin"
go env GOPATH
go env GOBIN
# asdfで管理しているすべてのバージョンのパスを通す
for version in $(ls ~/.asdf/installs/golang); do
    export PATH=$PATH:~/.asdf/installs/golang/$version/go/bin
done

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"


# Added by Windsurf
export PATH="/Users/daichiyamaoka/.codeium/windsurf/bin:$PATH"

# curl installed by brew
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"


. "$HOME/.local/bin/env"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# 1Password
eval "$(op completion zsh)"; compdef _op op
