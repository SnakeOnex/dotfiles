" basics

syntax on
syntax enable
filetype on
filetype indent on
filetype plugin indent on " for haskell-vim

set tabstop=4
set softtabstop=4 expandtab
set shiftwidth=4
set smartindent
set autoindent
set nowrap

set smartcase
"set noswapfile
set nobackup

set noerrorbells
set number
set relativenumber
set scrolloff=10

" undo directory
set undodir=~/.config/nvim/undodir
set undofile

set hidden
set history=100
set noshowmode

" haskell
"let g:haskell_indent_if = 2



" Vimtex
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

"autocmd BufRead,BufNewFile   *.tex setlocal wrap linebreak nnoremap j gj nnoremap k gk

autocmd BufRead,BufNewFile *.tex,*.md call SetTexOptions()

function SetTexOptions()
    setlocal wrap linebreak
    nnoremap j gj
    nnoremap k gk
endfunction


colorscheme default
let mapleader = ","
let maplocalleader = ","
"let mapleader = ","

set clipboard=unnamedplus

set nocompatible
filetype plugin indent on

nmap <leader>f :NERDTreeToggle<CR>

map <F5> :<C-U>!g++ -O2 -DLOCAL -std=c++14 -Wall -Wextra -Wno-unused-result -static %:r.cpp -o %:r<CR>

map <F9> :<C-U>!./%:r<CR>

" vim plug
call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/ownCloud/vimwiki',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'

Plug 'lervag/vimtex'


call plug#end()
