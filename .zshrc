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

#入力補完
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1

#######################################################
# Tools
#######################################################
# starship
eval "$(starship init zsh)"

# visual studio code alias
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh



# zsh-completions
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#   fpath=(${ASDF_DIR}/completions $fpath)
#   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#   autoload -Uz compinit
#   compinit
#   zstyle ':completion:*:default' menu select=1
# fi

# go, goenvのパス
# export GOPATH="$HOME/go"
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
# export PATH="$PATH:$GOPATH/bin"

