
DOT_FILES=(.zshrc .vimrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done

# ~/.config 以下
mkdir -p $HOME/.config/herdr
ln -s $HOME/dotfiles/herdr/config.toml $HOME/.config/herdr/config.toml
ln -s $HOME/dotfiles/starship.toml $HOME/.config/starship.toml
