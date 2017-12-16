set ruler
set number
autocmd ColorScheme * highlight LineNr ctermfg=12
highlight CursorLineNr ctermbg=4 ctermfg=0
set cursorline
highlight clear CursorLine
set showcmd

# status bar
let g:lightline = {
	\ 'colorscheme': 'solarized'
	\ }
set laststatus=2

syntax enable
set background=dark
colorscheme solarized

source ~/dotfiles/.vimrc
