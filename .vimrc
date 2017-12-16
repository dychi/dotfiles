set ruler
set number
autocmd ColorScheme * highlight LineNr ctermfg=12
highlight CursorLineNr ctermbg=4 ctermfg=0
highlight clear CursorLine
set showcmd

let g:lightline = {
	\ 'colorscheme': 'solarized'
	\ }
set laststatus=2

syntax enable
set background=dark
colorscheme solarized

