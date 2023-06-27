-- lspsaga.nvim (fork)
-- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
-- https://github.com/tami5/lspsaga.nvim
vim.cmd 'packadd lspsaga.nvim'

require'lspsaga'.init_lsp_saga {
  use_saga_diagnostic_sign = true,
  diagnostic_header_icon = '  ',
  use_diagnostic_virtual_text = false,
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = false,
    sign_priority = 20,
    virtual_text = true,
  },
  code_action_keys = {
    quit = '<ESC>', exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<ESC>', exec = '<CR>'
  },
  rename_prompt_prefix = '❯',
}
