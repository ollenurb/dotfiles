require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c',
        'scala',
        'kotlin',
        'haskell',
        'markdown',
        'lua',
        'latex'
    },
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
    },
}
