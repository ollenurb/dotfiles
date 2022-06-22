local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

-- Haskell
lspconfig.hls.setup {
    root_dir = util.root_pattern('*.hs','*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml')
}

-- Scala
lspconfig.metals.setup {
    root_dir = util.root_pattern('*.sc','*.scala', '*.sbt')
}

-- RUST
lspconfig.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
