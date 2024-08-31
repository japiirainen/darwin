local cmd = vim.cmd
local colorscheme = vim.cmd.colorscheme
local highlight = vim.cmd.highlight
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
highlight 'Keyword gui=bold'
highlight 'Comment gui=italic'
highlight 'Constant guifg=#999999'
highlight 'NormalFloat guibg=#333333'

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
o.updatecount = 0
o.ttyfast = true

-- use 'rg' when ':grep':ing.
cmd [[
set grepprg=rg\ --line-number\ --column
set grepformat=%f:%l:%c:%m
]]

-- Git
require('neogit').setup {}

-- Formatting
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff', 'ruff_fix', 'ruff_format' },
    nix = { 'nixpkgs_fmt' },
    ocaml = { 'ocamlformat' },
    zig = { 'zigfmt' },
    haskell = { 'fourmolu' },
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

-- directory browser/editor
require('oil').setup {}

-- key mappings

require('which-key').add {
  { '<leader>[', group = 'Prev' },
  { '<leader>[_', hidden = true },
  { '<leader>]', group = 'Next' },
  { '<leader>]_', hidden = true },
  { '<leader>g', group = '[G]it' },
  { '<leader>g_', hidden = true },
  { '<leader>l', group = '[L]sp' },
  { '<leader>l_', hidden = true },
  { '<leader>s', group = '[S]earch' },
  { '<leader>s_', hidden = true },
  { '<leader>t', group = 'Jump To [T]ag' },
  { '<leader>q', group = '[Q]uickfix' },
}
require('which-key').add({
  { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
  { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
}, { mode = 'v' })

-- exit insert mode with 'jk'
map('i', 'jk', '<Esc>')

-- jump to tag
map('n', '<leader>t', '<C-]>')

-- move text up and down in visual mode
map('x', '<s-j>', ":move '>+1<cr>gv-gv")
map('x', '<S-k>', ":move '<-2<CR>gv-gv")

-- lsp
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto Previous [D]iagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto Next [D]iagnostic' })
map('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Set [L]ocation list' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
map('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
map('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
map('n', '<leader>llr', vim.lsp.buf.references, { desc = '[R]eferences' })
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
map('n', '<leader>sg', ':GFiles<cr>', { desc = 'Search [G]it Files' })

-- files
map('n', '<leader><leader>', ':Files<cr>', { desc = 'Search For [F]ile' })
map('n', '<leader>sf', ':Files<cr>', { desc = 'Search For [F]ile' })
map('n', '<leader>ss', ':grep<space>', { desc = '[S]earch' })

-- quickfix
map('n', '[q', ':cprev<cr>', { desc = '[Q]uickfix next' })
map('n', ']q', ':cnext<cr>', { desc = '[Q]uickfix prev' })
map('n', '<leader>qo', ':copen<cr>', { desc = '[Q]uickfix open' })

-- completion
map('i', '<C-Space>', '<C-x><C-o>', { desc = 'Open completions' })

-- oil
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
