-- lua/plugins/catppuccin.lua
local M = {}

function M.setup()
    require("catppuccin").setup({
        flavour = "mocha", -- options: latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        integrations = {
            nvimtree = true,
            treesitter = true,
            lualine = true,
        },
    })

    -- Set colorscheme
    vim.cmd.colorscheme("catppuccin")
end

return M

