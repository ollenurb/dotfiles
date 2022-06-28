local o = vim.opt
local g = vim.g

-- Load impatient.nvim to cache plugins and improve startup time
require('impatient')

-- General configuration
require('onedark').load()

o.swapfile = false
o.showmode = false
o.ignorecase = true
o.number = true
o.termguicolors = true
o.hidden = true
o.backup = false
o.smartcase = true
o.mouse = 'a'
o.encoding = "utf-8"

-- Time to wait for a key to be pressed (in ms)
o.timeoutlen = 500

-- Tab Width
o.tabstop = 2
o.softtabstop = 0
o.expandtab = true
o.shiftwidth = 4
o.smarttab = true

-- KeyBindings
g.mapleader = " "

-- Set MaxWidth on Markdown and Text files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.md", "*.txt"},
    callback = function() o.textwidth = 80 end,
})

-- Plugins Options
g.better_whitespace_enabled = true
