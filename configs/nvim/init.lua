local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd
local map = vim.keymap.set

-- colorscheme variations

-- cmd "set background=light"
-- cmd "colorscheme NeoSolarized"

-- cmd "set background=dark"
-- cmd "colorscheme NeoSolarized"

-- cmd "set background=dark"
-- cmd "colorscheme iceberg"

-- cmd "set background=dark"
-- cmd "colorscheme zenburn"

-- cmd "set background=dark"
-- cmd "colorscheme base16-default-dark"

-- cmd "set background=dark"
-- cmd "colorscheme base16-onedark"

cmd "set background=dark"
cmd "colorscheme catppuccin_mocha"

-- cmd "set background=dark"
-- cmd "colorscheme default"

-- default light
-- cmd "set background=light"

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
wo.cursorline = true -- highlight current row?
wo.cursorlineopt = "both"
o.nu = false
o.relativenumber = true
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
o.autoread = true
o.list = true
o.listchars = "tab:→ ,trail:·,extends:›,precedes:‹,nbsp:·"

-- leader keys

g.mapleader = " "
g.maplocalleader = ","

-- mappings

map("i", "jk", "<Esc>")

g.copilot_enabled = true

-- custom handling of certain file extensions
vim.api.nvim_exec([[

autocmd BufNewFile,BufRead *.nue setfiletype html

]], false)
