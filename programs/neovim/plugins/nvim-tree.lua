require('nvim-tree').setup {
    disable_netrw = true,
    hijack_netrw = true,
    renderer = { root_folder_label = false, },
    view = {
        adaptive_size = true,
        side = "left",
    },
}
