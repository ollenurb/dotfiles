local o = vim.opt
local g = vim.g

-- Define useful functions for keybindings
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end


-- General configuration
vim.cmd[[colorscheme onedark]]
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

-- Tab Width
o.tabstop = 2
o.softtabstop = 0
o.expandtab = true
o.shiftwidth = 4
o.smarttab = true

-- KeyBindings
g.mapleader = " "
nmap("<Leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<Leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<Leader>fb", "<cmd>Telescope buffers<cr>  ")
nmap("<Leader>fh", "<cmd>Telescope help_tags<cr>")

-- Set MaxWidth on Markdown and Text files
local set_max_width = function() o.textwidth = 80 end

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.md", "*.txt"},
    callback = set_max_width,
})

-- Plugins Options
g.better_whitespace_enabled = true
