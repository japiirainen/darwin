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


