-- lua/plugins/whichkey.lua
local M = {}

function M.setup()
    local wk = require("which-key")
    wk.setup({})

    wk.add({
        -- Buffer navigation
        { "<C-l>", "<cmd>bnext<cr>", desc = "Next Buffer" },
        { "<C-h>", "<cmd>bprevious<cr>", desc = "Previous Buffer" },

        -- FILE EXPLORER
        { "<leader>e", group = "File Explorer" },
        { "<leader>en", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
        { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh File Tree" },
        { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Tree" },

        -- FIND
        { "<leader>f", group = "Find" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
        { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },

        -- TERMINAL
        { "<leader>t", group = "Terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
        { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },

        -- LSP
        { "<leader>l", group = "LSP" },
        { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
        { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
        { "<leader>lg", vim.lsp.buf.definition, desc = "Go to Definition" },
        { "<leader>lq", "<cmd>Trouble quickfix<cr>", desc = "Quickfix" },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", desc = "Format" },
        { "<leader>lh", vim.lsp.buf.hover, desc = "Trigger Hover on Cursor" },
        { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        { "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
        { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename Reference" },

        -- VISUAL MODE mappings
        {
            mode = { "v" },
            { "<", "<gv", desc = "Indent Right" },
            { ">", ">gv", desc = "Indent Left" },
            { "p", '"_dP', desc = "Paste Text" },
        },
    })
end

return M

