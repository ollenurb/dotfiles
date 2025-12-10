-- lua/plugins/blink.lua
local M = {}

function M.setup()
    require("blink.cmp").setup({
        keymap = {
            preset = "default",
        },
        completion = {
            accept = { "Enter", "Tab" },
            trigger = { "Manual", "TextChanged" },
        },
        snippets = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        sources = {
            default = { "lsp", "path", "buffer", "snippets" },
        },
        appearance = {
            use_nvim_cmp_icons = true,
        },
    })
end

return M

