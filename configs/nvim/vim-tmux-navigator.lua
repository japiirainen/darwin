vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<c-h>', ':TmuxNavigateLeft<cr>', { noremap = false , silent  = true})
vim.api.nvim_set_keymap('n', '<c-j>', ':TmuxNavigateDown<cr>', { noremap = true , silent  = true})
vim.api.nvim_set_keymap('n', '<c-k>', ':TmuxNavigateUp<cr>', { noremap= true , silent = true})
vim.api.nvim_set_keymap('n', '<c-l>', ':TmuxNavigateRight<cr>', { noremap = true , silent  = true})
