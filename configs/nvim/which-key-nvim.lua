local cmd = vim.cmd

cmd 'packadd harpoon'
require("harpoon").setup()
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- WhichKey maps

-- Define all `<Space>` prefixed keymaps with which-key.nvim
-- https://github.com/folke/which-key.nvim
cmd 'packadd which-key.nvim'
cmd 'packadd! gitsigns.nvim' -- needed for some mappings
local wk = require 'which-key'
wk.setup { plugins = { spelling = { enabled = true } } }

-- space prefixed in Normal mode
wk.register({
  -- Harpoon
  a = {
    a = { mark.add_file, 'Add file to harpoon' },
    e = { ui.toggle_quick_menu, 'Toggle quick menu' },
    h = { function() ui.nav_file(1) end, 'Navigate to file 1' },
    t = { function() ui.nav_file(2) end, 'Navigate to file 2' },
    n = { function() ui.nav_file(3) end, 'Navigate to file 3' },
    s = { function() ui.nav_file(4) end, 'Navigate to file 4' },
  },

  t = {
    name = "+Tabs",
    n = { "<Cmd>tabnew<CR>", "new tab" },
  },

  -- Git
  g = {
    name = "+Git",
    g = { "<Cmd>Neogit<CR>", "Open neogit" },
  },


  -- Seaching with telescope.nvim
  s = {
    name = '+Search',
    b = { '<Cmd>Telescope file_browser<CR>', 'File Browser' },
    f = { '<Cmd>Telescope find_files_workspace<CR>', 'Files in workspace' },
    F = { '<Cmd>Telescope find_files<CR>', 'Files in cwd' },
    g = { '<Cmd>Telescope live_grep_workspace<CR>', 'Grep in workspace' },
    G = { '<Cmd>Telescope live_grep<CR>', 'Grep in cwd' },
    l = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Buffer lines' },
    o = { '<Cmd>Telescope oldfiles<CR>', 'Old files' },
    t = { '<Cmd>Telescope builtin<CR>', 'Telescope lists' },
    w = { '<Cmd>Telescope grep_string_workspace<CR>', 'Grep word in workspace' },
    W = { '<Cmd>Telescope grep_string<CR>', 'Grep word in cwd' },
    v = {
      name = '+Vim',
      a = { '<Cmd>Telescope autocommands<CR>', 'Autocommands' },
      b = { '<Cmd>Telescope buffers<CR>', 'Buffers' },
      c = { '<Cmd>Telescope commands<CR>', 'Commands' },
      C = { '<Cmd>Telescope command_history<CR>', 'Command history' },
      h = { '<Cmd>Telescope highlights<CR>', 'Highlights' },
      q = { '<Cmd>Telescope quickfix<CR>', 'Quickfix list' },
      l = { '<Cmd>Telescope loclist<CR>', 'Location list' },
      m = { '<Cmd>Telescope keymaps<CR>', 'Keymaps' },
      s = { '<Cmd>Telescope spell_suggest<CR>', 'Spell suggest' },
      o = { '<Cmd>Telescope vim_options<CR>', 'Options' },
      r = { '<Cmd>Telescope registers<CR>', 'Registers' },
      t = { '<Cmd>Telescope filetypes<CR>', 'Filetypes' },
    },
    s = {
      function()
        require 'telescope.builtin'.symbols(require 'telescope.themes'.get_dropdown({
          sources = { 'emoji', 'math' } }))
      end, 'Symbols' },
    z = { '<Cmd>Telescope zoxide list<CR>', 'Z' },
    ['?'] = { '<Cmd>Telescope help_tags<CR>', 'Vim help' },
  },

  -- Open
  o = {
    name = "+Open",
    p = { '<Cmd>NvimTreeToggle<CR>', 'Open File Tree' },
  },

  -- Language servers
  l = {
    name = "LSP+",
    c = { '<Cmd>Lspsaga show_cursor_diagnostics<CR>', "Show cursor diagnostics" },
    C = { '<Cmd>Lspsaga show_workspace_diagnostics<CR>', "Show Workspace diagnostics" },
    f = { vim.lsp.buf.format, 'Format' },
    h = { '<Cmd>Lspsaga hover_doc<CR>', 'Hover' },
    n = { function() vim.diagnostic.goto_next({ float = false }) end, 'Jump to next diagnostic' },
    N = { function() vim.diagnostic.goto_prev({ float = false }) end, 'Jump to next diagnostic' },
    d = { vim.lsp.buf.definition, 'Jump to definition' },
    D = { vim.lsp.buf.declaration, 'Jump to declaration' },
    a = { '<Cmd>Lspsaga code_action<CR>', 'Code action' },
    r = { '<Cmd>Lspsaga rename<CR>', 'Rename' },
    l = {
      name = '+Lists',
      a = { '<Cmd>Telescope lsp_code_actions<CR>', 'Code actions' },
      A = { '<Cmd>Telescope lsp_range_code_actions<CR>', 'Code actions (range)' },
      r = { '<Cmd>Telescope lsp_references<CR>', 'References' },
      s = { '<Cmd>Telescope lsp_document_symbols<CR>', 'Documents symbols' },
      S = { '<Cmd>Telescope lsp_workspace_symbols<CR>', 'Workspace symbols' },
    },
  },

  f = { '<Cmd>Format<CR>', 'Format buffer using formatter-nvim' },
}, { prefix = "<leader>" })

-- Spaced prefiexd in mode Visual mode
wk.register({
  l = {
    name = '+LSP',
    a = { ':<C-U>Lspsaga range_code_action<CR>', 'Code action (range)', mode = 'v' },
  },
}, { prefix = ' ' })
