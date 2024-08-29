local cmd = vim.cmd
local colorscheme = vim.cmd.colorscheme
local map = vim.keymap.set
local g = vim.g
local o = vim.o
local wo = vim.wo

g.mapleader = ' '
g.maplocalleader = ','

cmd 'set nocompatible'

-- colorscheme + tweaks
cmd 'set background=dark'
colorscheme 'quiet'
cmd 'highlight Keyword gui=bold'
cmd 'highlight Comment gui=italic'
cmd 'highlight Constant guifg=#999999'
cmd 'highlight NormalFloat guibg=#333333'

local enable_red_cursor_block = false

if enable_red_cursor_block then
  cmd 'highlight Cursor guifg=red guibg=red'
  o.guicursor = 'a:block-Cursor/lCursor'
end

map('i', 'jk', '<Esc>')

-- move text up and down in visual mode
vim.keymap.set('x', '<s-j>', ":move '>+1<cr>gv-gv")
vim.keymap.set('x', '<S-k>', ":move '<-2<CR>gv-gv")

wo.number = true
wo.signcolumn = 'yes'
wo.cursorline = true
wo.cursorlineopt = 'both'
o.hlsearch = true
o.clipboard = 'unnamedplus'
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.updatetime = 50
o.completeopt = 'menuone,noselect'
o.termguicolors = true
o.scrolloff = 8
o.linebreak = true
o.colorcolumn = '80'
o.ruler = true
o.wildmenu = true
o.relativenumber = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.incsearch = true
o.autoread = true
o.list = true
o.listchars = 'tab:→ ,trail:·,extends:›,precedes:‹,nbsp:·'
o.conceallevel = 2

-- jump to tag
map('n', '<leader>t', '<C-]>')

cmd([[
set grepprg=rg\ --line-number\ --column
set grepprg=rg\ --line-number\ --column
]])

require('which-key').register {
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = 'Jump To [T]ag', _ = 'which_key_ignore' },
}

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

require('neogit').setup { }
map('n', '<leader>gg', ':Neogit<CR>', { desc = 'Toggle Neogit' })
