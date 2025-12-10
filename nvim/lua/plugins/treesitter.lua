-- lua/plugins/treesitter.lua
local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "html", "css", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
    })
end

return M
