return { -- which-key.nvim Keymap hints for the slow
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'helix',
        delay = 0,
        icons = { separator = '', group = '', rules = false },
        sort = { 'alphanum ' },
    },
}
