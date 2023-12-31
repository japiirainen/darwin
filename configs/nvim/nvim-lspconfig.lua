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

function M.on_attach(_, _)
end

local servers_config = {
  bashls = {},
  hls = {},

  tsserver = {},
  eslint = {},
  jsonls = {},
  html = {},
  cssls = {},
  tailwindcss = {},
  sourcekit = {},

  marksman = {},

  dhall_lsp_server = {},

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
    settings = {
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
  ruff_lsp = {},

  ocamllsp = {},

  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
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

function Enable_lspconfig()
  foreach(servers_config, function(_, k)
    lspconf[k].setup {}
  end)
end

Enable_lspconfig()

return M
