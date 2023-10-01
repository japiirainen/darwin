-- lspsaga.nvim (fork)
-- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
-- https://github.com/tami5/lspsaga.nvim
vim.cmd 'packadd lspsaga.nvim'

local saga = require 'lspsaga'

saga.setup {
  lightbulb = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = '<ESC>',
      exec = '<CR>'
    }
  },
  rename = {
    keys = {
      quit = '<ESC>',
      exec = '<CR>'
    }
  }
}
