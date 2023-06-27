local lean = require 'lean'

local on_attach = require 'nvim-lspconfig'.on_attach

lean.setup {
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    lsp3 = { on_attach = on_attach },
    mappings = true,
}
