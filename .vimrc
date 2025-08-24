call plug#begin()
Plug 'sainnhe/everforest'
Plug 'itchyny/lightline.vim'
call plug#end()

set laststatus=2
set background=dark
set number
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab

if has('termguicolors')
    set termguicolors
endif
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
let g:lightline = {}
let g:lightline.colorscheme = 'everforest'
colorscheme everforest

inoremap <ESC>h <Left>
inoremap <ESC>n <Down>
inoremap <ESC>e <Up>
inoremap <ESC>i <Right>

nnoremap <ESC>i i
nnoremap <ESC>e e
vnoremap <ESC>e e
onoremap <ESC>e e

nnoremap <A-left> :wincmd <<CR>
nnoremap <A-right> :wincmd ><CR>
nnoremap <A-up> :wincmd -<CR>
nnoremap <A-down> :wincmd +<CR>

nnoremap h h
nnoremap n j
nnoremap e k
nnoremap i l

vnoremap h h
vnoremap n j
vnoremap e k
vnoremap i l

onoremap h h
onoremap n j
onoremap e k
onoremap i l

cnoreabbrev Q q
cnoreabbrev W w
