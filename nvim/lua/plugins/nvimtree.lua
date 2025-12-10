-- lua/plugins/nvimtree.lua
local M = {}

function M.setup()
    -- disable netrw (the built-in file explorer) so nvim-tree can take over
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- recommended settings
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
            side = "left",
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
        },
    })

    -- optional keymap to toggle the tree
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
end

return M
