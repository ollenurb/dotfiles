call plug#begin('~/.vim/plugged')
    " Lua Library required by some plugins
    Plug 'nvim-lua/plenary.nvim'
    " Scala
    Plug 'derekwyatt/vim-scala'
    " Enable Language Server Support
    Plug 'neovim/nvim-lspconfig'
    " Tree Sitter (better syntax highlighting)
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Fuzzy Finder
    Plug 'nvim-telescope/telescope.nvim'
    " Fancy motions
    Plug 'ggandor/lightspeed.nvim'
    " Completion engine
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " Misc
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'godlygeek/tabular'
    Plug 'vim-latex/vim-latex'
    Plug 'vimwiki/vimwiki'
    Plug 'ntpeters/vim-better-whitespace'

    " Markdown
    Plug 'plasticboy/vim-markdown'

    " Haskell
    Plug 'neovimhaskell/haskell-vim'

    " Eye Candies
    Plug 'sainnhe/gruvbox-material'
    " Support colorized LSP
    Plug 'folke/lsp-colors.nvim'

    " Status bar
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons' " .. with icons support :)

    " Tab bar
    Plug 'akinsho/bufferline.nvim'

call plug#end()

" Basic stuff
filetype plugin on
syntax on
colorscheme gruvbox-material
set noswapfile
set ignorecase
set encoding=utf-8
set number
set termguicolors
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
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline_detect_whitespace = 0
" ----------------------------------------------------------------------------
" Language Server Protocol and Autocompletion stuff
" ----------------------------------------------------------------------------
luafile ~/.config/nvim/lsp-configs.lua
luafile ~/.config/nvim/cmp-nvim.lua
set shortmess-=F
set completeopt=menuone,noinsert,noselect

"-----------------------------------------------------------------------------
" Custom Bindings
"-----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bn :bn<CR>

"-----------------------------------------------------------------------------
" Load Plugin-Specific configurations
"-----------------------------------------------------------------------------
luafile ~/.config/nvim/plugins/lualine.lua
luafile ~/.config/nvim/plugins/bufferline.lua
