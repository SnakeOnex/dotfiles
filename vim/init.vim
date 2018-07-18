set number

filetype on
syntax on
colorscheme desert 
let mapleader = ","

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

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

Plug 'shime/vim-livedown'
let g:livedown_autorun = 1

Plug 'itchyny/lightline.vim'

Plug 'irrationalistic/vim-tasks'

let g:TasksMarkerBase = '☐'
let g:TasksMarkerDone = '✔'
let g:TasksMarkerCancelled = '✘'
let g:TasksDateFormat = '%Y-%m-%d %H:%M'
let g:TasksAttributeMarker = '@'
let g:TasksArchiveSeparator = '＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿'


"Plug 'davidhalter/jedi-vim'

"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-jedi'


" Javascript
Plug 'pangloss/vim-javascript'

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

Plug 'vim-syntastic/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'



call plug#end()
