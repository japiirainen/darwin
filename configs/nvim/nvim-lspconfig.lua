-- nvim-lspconfig
-- Configure available LSPs
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
--
-- Note that all languag e servers aside from `sumneko_lua` are installed via Nix. See:
-- `../../../../home/neovim.nix`.
local foreach = require 'pl.tablex'.foreach

local M = {}

-- Configures `sumneko_lua` properly for Neovim config editing when it makes sense.
require 'neodev'.setup {
  override = function(root_dir, library)
    if require 'neodev.util'.has_file(root_dir, "~/.config/nixpkgs/configs/nvim") then
      library.enabled = true
      library.runtime = true
      library.types = true
      library.plugins = true
    end
  end
}

local lspconf = require 'lspconfig'

function M.on_attach(client, bufnr)
end

local servers_config = {
  bashls = {},
  ccls = {},
  hls = {},
  jsonls = {},

  lua_ls = {
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  },

  nil_ls = {
    settings ={
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
  },

  pyright = {},
  sourcekit = {},
  tsserver = {},

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
        projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      },
      suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
      },
    }
  },

  yamlls = {
    settings = {
      yaml = {
        format = {
          printWidth = 100,
          singleQuote = true,
        },
      },
    },
  },
}

local coq = require 'coq'

foreach(servers_config, function(v, k)
  lspconf[k].setup(coq.lsp_ensure_capabilities(
   vim.tbl_extend('error', v, { on_attach = M.on_attach })
  ))
end)

return M