
DOT_FILES=(.zshrc .vimrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiels/$file $HOME/$file
done



