call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'

    " Fancy Discord integration (requires python3 support)
    " Plug 'hugolgst/vimsence'
    Plug 'godlygeek/tabular'
    Plug 'vim-latex/vim-latex'
    Plug 'vimwiki/vimwiki'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'itchyny/lightline.vim'

    " Colorschemes
    Plug 'kyoz/purify', { 'rtp': 'vim' }
    Plug 'morhetz/gruvbox'

    " Markdown
    Plug 'plasticboy/vim-markdown'

    " Haskell related
    Plug 'neovimhaskell/haskell-vim'
    Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
call plug#end()

" Basic stuff
filetype plugin on
syntax on
colorscheme purify
set noswapfile
set ignorecase
set encoding=utf-8
set number
set hidden
set nobackup
set smartcase
set mouse=a
set tabstop=2 softtabstop=0 expandtab shiftwidth=4 smarttab

" VimSence
" let g:vimsence_small_text = 'NeoVim'
" let g:vimsence_small_image = 'neovim'
" let g:vimsence_custom_icons = {'haskell': 'hs', 'vimwiki': 'md'}

" MaxWidth on markdown files
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

