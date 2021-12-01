call plug#begin('~/.vim/plugged')
    " Lua Library required by some plugins
    Plug 'nvim-lua/plenary.nvim'
    " Scala
    Plug 'derekwyatt/vim-scala'
    " Enable Language Server Support
    Plug 'neovim/nvim-lspconfig'
    " Autocomplete (to be used by LSP's)
    Plug 'ms-jpq/coq_nvim'
    " Tree Sitter (better syntax highlighting)
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Fuzzy Finder
    Plug 'nvim-telescope/telescope.nvim'
    " Fancy motions
    Plug 'ggandor/lightspeed.nvim'

    " Misc
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'godlygeek/tabular'
    Plug 'vim-latex/vim-latex'
    Plug 'vimwiki/vimwiki'
    Plug 'ntpeters/vim-better-whitespace'

    " Stats (www.wakatime.com)
    Plug 'wakatime/vim-wakatime'

    " Markdown
    Plug 'plasticboy/vim-markdown'

    " Haskell
    Plug 'neovimhaskell/haskell-vim'

    " Eye Candies
    Plug 'sainnhe/gruvbox-material'
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vifm/vifm.vim'
call plug#end()

" Basic stuff
filetype plugin on
syntax on
colorscheme gruvbox
set noswapfile
set ignorecase
set encoding=utf-8
set number
set hidden
set nobackup
set smartcase
set mouse=a
set tabstop=2 softtabstop=0 expandtab shiftwidth=4 smarttab
let mapleader=" "

" MaxWidth on markdown files
au BufNewFile,BufRead *.md
    \ set textwidth=80

" Better Whitespace
let g:better_whitespace_enabled=1

" ----------------------------------------------------------------------------
" Airline settings
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
" ----------------------------------------------------------------------------
" Language Server Protocol
" ----------------------------------------------------------------------------
luafile ~/.config/nvim/lsp_configs.lua
set shortmess-=F
"-----------------------------------------------------------------------------
" Custom Bindings
"-----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bn :bn<CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
