local cmd = vim.cmd
local colorscheme = vim.cmd.colorscheme
local highlight = vim.cmd.highlight
local map = vim.keymap.set
local g = vim.g
local o = vim.o
local wo = vim.wo

g.mapleader = ' '
g.maplocalleader = ','

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'mg979/vim-visual-multi',
  'rsmenon/vim-mathematica',
  'kana/vim-textobj-user',

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    'stevearc/conform.nvim',
    config = true,
    opts = {
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
    },
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {}
      map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function mapp(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        mapp({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        mapp({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        mapp('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        mapp('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        mapp('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        mapp('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        mapp('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        mapp('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        mapp('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        mapp('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        mapp('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        mapp('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        mapp('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        mapp('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        mapp('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        mapp({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },

  { dependencies = {
    'nvim-lua/plenary.nvim',
  }, 'ThePrimeagen/harpoon' },

  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end,
  },

  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. 'dev/jp-vault/**.md',
      'BufNewFile ' .. vim.fn.expand '~' .. 'dev/jp-vault/**.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/dev/jp-vault/',
        },
      },

      new_notes_location = 'current_dir',

      daily_notes = {
        folder = 'daily',
      },

      follow_url_func = function(url)
        vim.fn.jobstart { 'open', url }
      end,
    },
  },
}

-- basic vim/neovim settings

cmd 'set background=dark'
colorscheme 'quiet'
highlight 'Keyword gui=bold'
highlight 'Comment gui=italic'
highlight 'Constant guifg=#999999'
highlight 'NormalFloat guibg=#333333'

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
o.updatecount = 0
o.ttyfast = true

-- use 'rg' when ':grep':ing.
cmd [[
set grepprg=rg\ --line-number\ --column
set grepformat=%f:%l:%c:%m
]]

-- quickfix
map('n', '[q', ':cprev<cr>', { desc = '[Q]uickfix next' })
map('n', ']q', ':cnext<cr>', { desc = '[Q]uickfix prev' })
map('n', '<leader>qo', ':copen<cr>', { desc = '[Q]uickfix open' })

-- jump to tag
map('n', '<leader>t', '<C-]>')

-- telescope
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist(
    'git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel'
  )[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
map(
  'n',
  '<leader>?',
  require('telescope.builtin').oldfiles,
  { desc = '[?] Find recently opened files' }
)
map(
  'n',
  '<leader><space>',
  require('telescope.builtin').buffers,
  { desc = '[ ] Find existing buffers' }
)
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

map('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
map(
  'n',
  '<leader>ss',
  require('telescope.builtin').builtin,
  { desc = '[S]earch [S]elect Telescope' }
)
map('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
map(
  'n',
  '<leader>sw',
  require('telescope.builtin').grep_string,
  { desc = '[S]earch current [W]ord' }
)
map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
map(
  'n',
  '<leader>sd',
  require('telescope.builtin').diagnostics,
  { desc = '[S]earch [D]iagnostics' }
)
map('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Treesitter
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'haskell',
      'nix',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- goto-preview

map('n', '<leader>lgd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', {
  desc = 'Goto Preview Definition',
})
map('n', '<leader>lgt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', {
  desc = 'Goto Preview Type Definition',
})
map('n', '<leader>lgi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', {
  desc = 'Goto Preview Implementation',
})
map('n', '<leader>lgr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', {
  desc = 'Goto Preview References',
})
map('n', '<leader>lgq', '<cmd>lua require("goto-preview").close_all_win()<CR>', {
  desc = 'Close all Goto Preview windows',
})

-- harpoon

require('harpoon').setup()
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

map('n', '<leader>aa', mark.add_file, { desc = 'Add file to harpoon' })
map('n', '<leader>ae', ui.toggle_quick_menu, { desc = 'Toggle quick menu' })
map('n', '<leader>ah', function()
  ui.nav_file(1)
end, { desc = 'Navigate to file 1' })
map('n', '<leader>at', function()
  ui.nav_file(2)
end, { desc = 'Navigate to file 2' })
map('n', '<leader>an', function()
  ui.nav_file(3)
end, { desc = 'Navigate to file 3' })
map('n', '<leader>as', function()
  ui.nav_file(4)
end, { desc = 'Navigate to file 4' })

-- lsp-servers

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  bashls = {},
  hls = {},

  sourcekit = {},

  clangd = {},

  tsserver = {},
  eslint = {},
  jsonls = {},
  html = {},
  cssls = {},
  tailwindcss = {},

  marksman = {},

  dhall_lsp_server = {},

  nil_ls = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
      nix = {
        flake = {
          autoArchive = true,
          autoEvalInputs = false,
        },
      },
    },
  },

  pyright = {},
  ruff_lsp = {},

  rust_analyzer = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      files = {
        excludeDirs = { '.direnv' },
      },
    },
  },

  zls = {},

  vimls = {
    init_options = {
      iskeyword = '@,48-57,_,192-255,-#',
      vimruntime = vim.env.VIMRUNTIME,
      runtimepath = vim.o.runtimepath,
      diagnostic = {
        enable = true,
      },
      indexes = {
        runtimepath = true,
        gap = 100,
        count = 8,
        projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
      },
      suggest = {
        fromRuntimepath = true,
        fromVimruntime = true,
      },
    },
  },

  ocamllsp = {},
}

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('<leader>ld', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('<leader>llr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>lli', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap(
    '<leader>lws',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols'
  )

  -- See `:help K` for why this keymap
  nmap('<leader>lh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto Previous [D]iagnostic' })
  map('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto Next [D]iagnostic' })
  nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').add {
  { '<leader>[', group = 'Prev' },
  { '<leader>]', group = 'Next' },
  { '<leader>a', group = 'Harpoon' },
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]atabase' },
  { '<leader>g', group = '[G]it' },
  { '<leader>gh', group = '[H]istory' },
  { '<leader>h', group = 'Git [H]unk' },
  { '<leader>l', group = '[L]sp' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>i', group = '[I]nput' },
  { '<leader>x', group = 'Trouble Diagnostics' },
  { '<leader>t', group = 'Jump To [T]ag' },
  { '<leader>q', group = '[Q]uickfix' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').add({
  { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
  { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
}, { mode = 'v' })

require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local lspconf = require 'lspconfig'

for server_name, config in pairs(servers) do
  lspconf[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = config,
    filetypes = (config or {}).filetypes,
  }
end

-- nvim-cmp
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- neogit

map('n', '<leader>gg', ':Neogit<CR>', { desc = 'Toggle Neogit' })
