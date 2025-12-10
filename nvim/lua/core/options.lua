local o = vim.opt
local g = vim.g

-- Setup colorscheme
o.background = "dark"

-- General configuration
o.swapfile = false
o.showmode = false
o.ignorecase = true
o.number = true
o.termguicolors = true
o.hidden = true
o.backup = false
o.smartcase = true
o.mouse = 'a'
o.encoding = 'utf-8'
o.relativenumber = true
o.cursorline = true

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
