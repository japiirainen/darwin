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

-- use 'rg' when ':grep':ing.
cmd [[
set grepprg=rg\ --line-number\ --column
set grepprg=rg\ --line-number\ --column
]]

-- Git
require('neogit').setup {}

-- Formatting
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff', 'ruff_fix', 'ruff_format' },
    nix = { 'nixfmt' },
    ocaml = { 'ocamlformat' },
    zig = { 'zigfmt' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
  },
  format_on_save = {},
}

-- lsp
local lsp = require 'lspconfig'
lsp.zls.setup {}
lsp.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
lsp.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}
lsp.hls.setup {}
lsp.pyright.setup {}
lsp.ruff_lsp.setup {}
lsp.tsserver.setup {}
lsp.eslint.setup {}
lsp.tailwindcss.setup {}

-- key mappings

require('which-key').register {
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]sp', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = 'Jump To [T]ag', _ = 'which_key_ignore' },
}
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

-- exit insert mode with 'jk'
map('i', 'jk', '<Esc>')

-- jump to tag
map('n', '<leader>t', '<C-]>')

-- move text up and down in visual mode
map('x', '<s-j>', ":move '>+1<cr>gv-gv")
map('x', '<S-k>', ":move '<-2<CR>gv-gv")

-- lsp
map('n', '<leader>lp', vim.diagnostic.goto_prev, { desc = 'Goto [P]revious' })
map('n', '<leader>ln>', vim.diagnostic.goto_next, { desc = 'Goto [N]ext' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
map('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
map('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
map('n', '<leader>lrr', vim.lsp.buf.references, { desc = '[R]efe[R]ences' })
map('n', '<leader>lh', vim.lsp.buf.signature_help, { desc = 'Signature [Help]' })
map('n', 'gd', '<C-]>', { desc = '[G]oto [Definition]' })

-- tmux - nvim navigation
map('n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>')
map('n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>')
map('n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>')
map('n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>')
map('n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>')

-- git
map('n', '<leader>gg', ':Neogit<CR>', { desc = 'Toggle Neogit' })
map('n', '<leader>gf', ':GFiles<cr>', { desc = 'Git [F]iles' })

-- files
map('n', '<leader><leader>', ':Files<cr>', { desc = 'Find files' })
map('n', '<leader>ff', ':Files<cr>', { desc = 'Find files' })
map('n', '<leader>fs', ':grep<space>', { desc = 'Find from files' })

-- quickfix
map('n', '[q', ':cprev<cr>', { desc = 'Quickfix next' })
map('n', ']q', ':cnext<cr>', { desc = 'Quickfix prev' })

-- completion
map('i', '<C-Space>', '<C-x><C-o>', { desc = 'Open completions' })
