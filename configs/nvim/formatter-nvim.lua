require('formatter').setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    typescript = {
      -- prettierd
      function()
        return {
          exe = "prettier",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    typescriptreact = {
      -- prettierd
      function()
        return {
          exe = "prettier",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    javascriptreact = {
      -- prettierd
      function()
        return {
          exe = "prettier",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    javascript = {
      -- prettierd
      function()
        return {
          exe = "prettier",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          stdin = true
        }
      end
    },
    sql = {
      function()
        return {
          exe = "sqlformat",
          args = { vim.api.nvim_buf_get_name(0), '-a' },
          stdin = true
        }
      end
    },
    haskell = {
      function()
        return {
          exe = "fourmolu --unicode detect",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    ocaml = {
      function()
        return {
          exe = "ocamlformat",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = { "-q", "-" },
          stdin = true
        }
      end
    },
    c = {
      function()
        return {
          exe = "clang-format",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    nix = {
      function()
        return {
          exe = "nixpkgs-fmt",
          stdin = true
        }
      end
    },
  }
})

-- vim.api.nvim_exec([[
--
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost * FormatWrite
-- augroup END
--
-- ]], false)
