-- oil-nvim

local map = vim.keymap.set

require('oil').setup({})

map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
