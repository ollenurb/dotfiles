local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local rust = require 'rust-tools'

-- LSP Diagnostic Options
function sign(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ""
    })
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn",  text = "" })
sign({ name = "DiagnosticSignHint",  text = "" })
sign({ name = "DiagnosticSignInfo",  text = "" })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Rust
rust.setup({
    -- server = {
    --     settings = {
    --         ["rust-analyzer"] = {
    --             checkOnSave = {
    --                 command = "clippy",
    --             },
    --         },
    --     },
    -- },
})

-- C++
lspconfig.clangd.setup({})
