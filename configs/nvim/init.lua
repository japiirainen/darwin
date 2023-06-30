local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd
local map = vim.keymap.set

-- colorscheme

cmd "colorscheme NeoSolarized"

-- some basic vim settings

o.scrolloff = 10
o.linebreak = true
o.mouse = 'a'
o.updatetime = 50
o.colorcolumn = "80"
o.ruler = true
o.completeopt = "menuone,noselect"
o.wildmenu = true
o.clipboard = "unnamedplus"
-- o.guicursor = ""
wo.cursorline = false
wo.cursorlineopt = "number"
o.nu = false
o.relativenumber = false
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"

-- leader keys

g.mapleader = " "
g.maplocalleader = ","

-- mappings

map("i", "jk", "<Esc>")
