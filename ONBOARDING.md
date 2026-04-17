# dotfiles オンボーディング（zsh 版）

新しい macOS マシンでこの dotfiles を使って zsh 環境を構築するためのガイドです。

## 概要

- **シェル**: zsh
- **プロンプト**: starship
- **プラグインマネージャ**: zinit（初回起動時に自動インストール）
- **バージョン管理**: asdf
- **ターミナルマルチプレクサ**: tmux
- **履歴検索**: peco（`Ctrl-R`）
- **便利ツール**: bat, direnv, 1Password CLI

## 前提条件

Homebrew で必要なツールを入れます。

```sh
# Homebrew（未インストールの場合）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 必須ツール
brew install zsh vim tmux starship asdf direnv peco bat 1password-cli
```

## セットアップ手順

### 1. リポジトリを clone する

```sh
git clone <このリポジトリ> ~/dotfiles
cd ~/dotfiles
```

`~/dotfiles` 以外に置く場合は、`.zshrc` の `DOTFILES_PATH` と `setup.sh` を合わせて修正してください。

### 2. シンボリックリンクを作成する

```sh
./setup.sh
```

`.zshrc` / `.vimrc` / `.tmux.conf` が `$HOME` にリンクされます。同名ファイルが既にある場合は先に退避してください。

### 3. starship 設定を配置する

```sh
mkdir -p ~/.config
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
```

### 4. vim カラースキームを配置する

```sh
mkdir -p ~/.vim/colors
cp ~/dotfiles/bin/solarized.vim ~/.vim/colors/
```

### 5. asdf で Go を入れる（必要なら）

```sh
asdf plugin add golang
asdf install golang latest
asdf global golang latest
```

### 6. zsh をログインシェルにして起動し直す

```sh
chsh -s $(which zsh)
exec $SHELL -l
```

初回起動時に zinit が自動で `~/.local/share/zinit` に clone され、以下が読み込まれます。

- `zsh-syntax-highlighting` — シンタックスハイライト
- `zsh-completions` — 補完強化
- `zsh-autosuggestions` — 履歴ベースの入力補完
- `history-search-multi-word` — 履歴検索

## 主な機能

### Git エイリアス（`zsh/alias.zsh`）

| エイリアス | 展開先 |
|---|---|
| `gst` | `git status` |
| `gad` | `git add` |
| `gcm` | `git commit` |
| `gpush` | `git push` |
| `gpull` | `git pull` |
| `gfetch` | `git fetch` |
| `gdiff` | `git diff` |
| `gchout` | `git checkout` |
| `gswitch` | `git switch` |
| `gwt` | `git worktree` |

### その他エイリアス

- `ll` → `ls -Flh`
- `cat` → `bat`（bat がインストールされている場合）

### キーバインド

- `Ctrl-R` — peco でコマンド履歴をインクリメンタル検索
- `↑` / `↓` — 入力済み文字列で始まるコマンドを履歴から検索

## ディレクトリ構成

```
dotfiles/
├── .zshrc              # zsh のエントリポイント
├── .vimrc              # vim 設定
├── .tmux.conf          # tmux 設定
├── starship.toml       # プロンプト設定
├── setup.sh            # シンボリックリンク作成スクリプト
├── zsh/
│   ├── alias.zsh       # エイリアス定義
│   ├── plugins.zsh     # zinit プラグイン設定
│   └── functions.zsh   # peco 履歴検索など
└── bin/
    ├── battery         # tmux バッテリー表示
    ├── wifi            # tmux Wi-Fi 表示
    └── solarized.vim   # vim カラースキーム
```

---

## Q&A: `Ctrl-R` で履歴検索が動かないとき

このリポジトリでは、`zsh/functions.zsh` で `Ctrl-R` に peco ベースの履歴検索をバインドしています。動かない場合は以下を順にチェックしてください。

### Q1. `Ctrl-R` を押しても何も起きない／`bash` の逆順検索が出る

**原因の切り分け:**

```sh
# 1. 自分のシェルが zsh か確認
echo $SHELL
# → /bin/zsh または /opt/homebrew/bin/zsh であること

# 2. 関数がロードされているか確認
bindkey '^R'
# → "peco-history-selection" と表示されれば OK
# → "history-incremental-search-backward" だと未ロード
```

`bash` が出ている場合は `chsh -s $(which zsh)` でログインシェルを zsh に切り替え、ターミナルを開き直してください。

### Q2. `peco: command not found` と出る

peco が未インストールです。

```sh
brew install peco
exec $SHELL -l
```

### Q3. `Ctrl-R` を押すと画面が固まる／真っ黒になる

peco 起動中はそのウィンドウが peco の UI になります。

- 検索文字を入力 → `Enter` で確定
- `Esc` または `Ctrl-C` でキャンセル

何も表示されない場合は、後述の Q4（履歴ファイルが空）を確認してください。

### Q4. 履歴が空 or 過去のコマンドが出てこない

履歴ファイルが設定されていない可能性があります。

```sh
echo $HISTFILE
# → 空ならこのセッションの履歴が保存されない
```

`.zshrc` に以下が無ければ追加してください（このリポジトリでは `HISTSIZE` / `SAVEHIST` のみ設定されているため、`HISTFILE` を別途指定することを推奨）。

```sh
export HISTFILE=~/.zsh_history
```

反映後、いくつかコマンドを打ち、新しいシェルで `Ctrl-R` を押すと履歴が出てきます。

### Q5. macOS のターミナル設定で `Ctrl-R` が奪われている

`iTerm2` や `Terminal.app` のキー割当てで `^R` に別アクションが入っていないか確認してください。

- **iTerm2**: Settings → Keys → Key Bindings で `^R` を削除
- **Terminal.app**: Settings → Profiles → Keyboard でカスタム割当を削除

### Q6. tmux 内だと動かない

tmux のプレフィックスは `C-a`（`.tmux.conf` で変更済）です。`C-b` と競合することはありませんが、以下を確認:

```sh
# tmux の外で動作するか確認
tmux kill-server
# 新しい素のシェルで Ctrl-R を試す
```

素のシェルで動くなら tmux 設定、動かないなら zsh 設定の問題です。

### Q7. `zle -N` / `bindkey` は通っているのに動かない

`zsh/functions.zsh` が source されていない可能性があります。

```sh
# 手動で source してみる
source ~/dotfiles/zsh/functions.zsh
bindkey '^R'
# → peco-history-selection になれば関数側は OK
```

`.zshrc` の `source "$DOTFILES_PATH/zsh/functions.zsh"` が評価されているか確認してください。`DOTFILES_PATH` が間違っていると読み込まれません。

```sh
echo $DOTFILES_PATH
ls $DOTFILES_PATH/zsh/functions.zsh
```

### Q8. peco の代わりに fzf を使いたい

`zsh/functions.zsh` を次のように書き換えれば fzf に置き換えられます。

```sh
function fzf-history-selection() {
  BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | fzf)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection
```

事前に `brew install fzf` を忘れずに。

---

## カスタマイズ

- エイリアス追加: `zsh/alias.zsh` を編集
- 関数追加: `zsh/functions.zsh` を編集
- マシン固有の設定: `.zshrc` 末尾に追記するか、`~/.zshrc.local` を作って `source` する

変更後は `exec $SHELL -l` で反映。
