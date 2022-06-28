local wk = require('which-key')

wk.setup { }

-- Normal mode bindings
wk.register({

    ["<Leader>"] = {
        f = {
            name = "Find",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
            h = { "<cmd>Telescope help_tags<cr>", "Find Help Tags" },
            n = { "<cmd>enew<cr>", "New File" },
        },

        e = {
            name = "File Explorer",
            n = { "<cmd>NvimTreeToggle<cr>", "Toggle File Tree" },
            r = { "<cmd>NvimTreeRefresh<cr>", "Refresh File Tree" },
            f = { "<cmd>NvimTreeFindFile<cr>", "Find File in Tree" },
        },

        t = {
            name = "Terminal",
            f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
            h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
            v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },

        l = {
            name = "LSP",
            e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
            d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Buffer Diagnostics" },
            w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {
              "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
              "Workspace Symbols",
            },
            g = { vim.lsp.buf.definition, "Go to definition" },
            i = { "<cmd>LspInfo<cr>", "Info" },
            a = { vim.lsp.buf.code_action, "Code Action" },
            f = { vim.lsp.buf.formatting, "Format" },
            h = { vim.lsp.buf.hover, "Trigger Hover on cursor" },
            j = { vim.diagnostic.goto_next, "Next Diagnostic" },
            k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
            l = { vim.lsp.codelens.run, "CodeLens Action" },
            q = { vim.diagnostic.setloclist, "Quickfix" },
            r = { vim.lsp.buf.rename, "Rename Reference" },
        },
    },

    -- Navigate Buffers Easily
    ["<C-l>"] = { "<cmd>bnext<cr>", "Next Buffer" },
    ["<C-h>"] = { "<cmd>bprevious<cr>", "Next Previous" },

})

-- Visual mode bindings
wk.register({

    -- Keep visual mode while indenting
    ["<"] = { "<gv", "Indent Right" },
    [">"] = { ">gv", "Indent Left" },

    -- Avoid deleting the last thing inside the clipboard register
    ["p"] = { '"_dP', "Paste Text" },

}, { mode = "v" })
