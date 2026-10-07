# dotfiles

macOS 向けの個人 dotfiles。**PC を買い替えたときに、同じ環境をすぐ再現できること**が最大の目的です。

## 必須ルール: 設定を変えたらセットアップも更新する

設定ファイルを追加・変更・削除したら、同じ変更の中で、関連する初期セットアップのドキュメントやスクリプトも**必ず**更新してください。設定だけ変えて、セットアップが古いまま残る状態にしないこと。

| 変更の内容 | 更新するもの |
|---|---|
| 設定ファイルの追加・削除・移動（`$HOME` や `~/.config` へのリンクが要るもの） | `setup.sh` と `ONBOARDING.md` の「セットアップ手順」「ディレクトリ構成」 |
| 使うツールの追加・削除（`brew install` が要るもの） | `ONBOARDING.md` の「概要」と「前提条件」の `brew install` |
| キーバインド・エイリアス・prefix などユーザーが覚える操作の変更 | `ONBOARDING.md` の「主な機能」 |
| 手動手順が増える設定（プラグイン導入、権限設定、`asdf` など） | `ONBOARDING.md` の「セットアップ手順」 |
| よくある不具合の解決策が分かった | `ONBOARDING.md` の Q&A |

完了前に、次を確認してください。
- `ONBOARDING.md` の手順を新しい PC で上から順に実行すれば、今の環境になるか。
- `setup.sh` が、リポジトリにある設定ファイルをすべてリンクしているか（`bash -n setup.sh` で構文も確認）。
- `ONBOARDING.md` のディレクトリ構成が、実際のファイル構成と一致しているか。

## 構成

- `.zshrc` / `.vimrc` / `.tmux.conf` → `setup.sh` で `$HOME` にリンク
- `herdr/config.toml` → `setup.sh` で `~/.config/herdr/` にリンク
- `starship.toml` → `setup.sh` で `~/.config/starship.toml` にリンク
- `zsh/` → `.zshrc` から `source`（エイリアス、プラグイン、関数）
- `bin/` → 補助スクリプトと vim カラースキーム

## 作業時の注意

- `setup.sh` の `ln -s` は既存ファイルを上書きしません（`-f` は付けません）。この挙動は維持してください。
- 設定の変更後は、可能な範囲で検証してください。
  - herdr: `herdr config check`（反映は `herdr server reload-config`）
  - tmux: 別ソケットで起動して確認（`tmux -L <name> -f .tmux.conf new-session -d`）
  - シェルスクリプト: `bash -n`
- 秘密情報（トークン、API キー、認証情報）はコミットしないでください。
- ドキュメント（`ONBOARDING.md` など）は日本語で書きます。
