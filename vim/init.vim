set number

filetype on
syntax on
colorscheme desert 


set hidden
set history=100

filetype indent on
set nowrap
set smartindent
set autoindent

" setting tab to be 4 spaces
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4




set hlsearch

" LUL

" disable the OG -- INSERT -- indicator
set noshowmode

"let g:deoplete#enable_at_startup = 1

" vim plug
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
"Plug 'davidhalter/jedi-vim'

"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-jedi'


call plug#end()
