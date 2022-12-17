local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local rust = require 'rust-tools'

-- Haskell
lspconfig.hls.setup {
    root_dir = util.root_pattern(
        '*.hs',
        '*.cabal',
        'stack.yaml',
        'cabal.project',
        'package.yaml',
        'hie.yaml'
    )
}

-- Scala
lspconfig.metals.setup {
    root_dir = util.root_pattern(
        '*.sc',
        '*.scala',
        '*.sbt'
    ),
    statusBarProvider = 'show-message',
}

-- Rust
rust.setup({})

-- Rust
lspconfig.clangd.setup({})
