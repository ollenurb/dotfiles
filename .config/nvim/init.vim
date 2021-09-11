call plug#begin('~/.vim/plugged')
    " Scala
    Plug 'derekwyatt/vim-scala'
    Plug 'scalameta/nvim-metals' " lsp support

    " Enable language server
    Plug 'neovim/nvim-lspconfig'

    " Misc
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'godlygeek/tabular'
    Plug 'vim-latex/vim-latex'
    Plug 'vimwiki/vimwiki'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'nvim-lua/completion-nvim'

    " Stats (www.wakatime.com)
    Plug 'wakatime/vim-wakatime'

    " Markdown
    Plug 'plasticboy/vim-markdown'

    " Haskell
    Plug 'neovimhaskell/haskell-vim'
    Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

    " Fancy stuff
    Plug 'kyoz/purify', { 'rtp': 'vim' }
    Plug 'morhetz/gruvbox'
    Plug 'itchyny/lightline.vim'
    Plug 'ryanoasis/vim-devicons'

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

" Language Server Protocol-Related
set shortmess-=F

"-----------------------------------------------------------------------------
" nvim-metals setup with a few additions such as nvim-completions
"-----------------------------------------------------------------------------
:lua << EOF
  metals_config = require'metals'.bare_config
  metals_config.settings = {
     showImplicitArguments = true,
     excludedPackages = {
       "akka.actor.typed.javadsl",
       "com.github.swagger.akka.javadsl"
     }
  }

  metals_config.on_attach = function()
    require'completion'.on_attach();
  end

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '',
      }
    }
  )
EOF

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end
endif

"-----------------------------------------------------------------------------
" completion-nvim settings
"-----------------------------------------------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
