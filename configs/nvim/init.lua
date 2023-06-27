local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd
local map = vim.keymap.set

-- colorscheme

cmd "colorscheme NeoSolarized"

-- some basic vim settings

o.scrolloff = 10
o.linebreak = true
o.mouse = 'a'
o.updatetime = 50
o.colorcolumn = "80"
o.ruler = true
o.completeopt = "menuone,noselect"
o.wildmenu = true
o.clipboard = "unnamedplus"
o.guicursor = ""
wo.cursorline = false
wo.cursorlineopt = "number"
o.nu = false
o.relativenumber = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"

-- leader keys

g.mapleader = " "
g.maplocalleader = ","

-- mappings

map("i", "jk", "<Esc>")

-- telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim
local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'

telescope.setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        color_devicons = true,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        winblend = 10,
        mappings = {
            n = {
                ['<CR>'] = actions.select_default + actions.center,
                s = actions.select_horizontal,
                v = actions.select_vertical,
                t = actions.select_tab,
                j = actions.move_selection_next,
                k = actions.move_selection_previous,
                u = actions.preview_scrolling_up,
                d = actions.preview_scrolling_down,
            },
        },
    },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'
telescope.load_extension 'hoogle'
telescope.load_extension 'zoxide'

-- nvim-tree-lua

require('nvim-tree').setup({
    hijack_cursor = true,
    update_focused_file = { enable = true },
    view = {
        width = 35,
        side = 'right'
    },
    renderer = {
        icons = {
            git_placement = "signcolumn",
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true
            }
        }
    }
})

-- WhichKey maps

-- Define all `<Space>` prefixed keymaps with which-key.nvim
-- https://github.com/folke/which-key.nvim
cmd 'packadd which-key.nvim'
cmd 'packadd! gitsigns.nvim' -- needed for some mappings
local wk = require 'which-key'
wk.setup { plugins = { spelling = { enabled = true } } }

-- space prefixed in Normal mode
wk.register({
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
