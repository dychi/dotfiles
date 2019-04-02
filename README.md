
# dotfiles

This dotfiles can be used for developing your enviroment.

## Requirement

- vim
- zsh
- tmux 
- solarized
- oh-my-zsh

## Usage
1. clone this directory
2. move bin/solarized.vim to ~/.vim/colors/
3. create sybolic link
```
ln -s {path to dotfile}/.tmux.conf ~/.tmux.conf
ln -s {path to dotfile}/.vimrc ~/.vimrc
ln -s {path to dotfile}/.zshrc ~/.zshrc
```
4. activate those files
```
source ~/.{setting file}
```

