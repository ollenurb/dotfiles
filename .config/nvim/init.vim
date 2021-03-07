" Plugins
call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    " Haskell related
    Plug 'neovimhaskell/haskell-vim'
    Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
    Plug 'derekelkins/agda-vim'
    Plug 'vim-latex/vim-latex'
    Plug 'vimwiki/vimwiki'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'itchyny/lightline.vim'
call plug#end()

" Basic stuff
filetype plugin on

syntax on
set noswapfile
set ignorecase
set encoding=utf-8
set number
set hidden
set nobackup
set smartcase
set mouse=a
set tabstop=2 softtabstop=0 expandtab shiftwidth=4 smarttab

au BufNewFile,BufRead *.md
    \ set textwidth=100

" Statusline config
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Better Whitespace
let g:better_whitespace_enabled=1

