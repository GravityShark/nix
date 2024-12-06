return { -- which-key.nvim Keymap hints for the slow
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
        wk.setup({
            delay = 0,
            win = { no_overlap = false },
            icons = { separator = '', group = '', rules = false },
            sort = { 'alphanum ' },
        })
        wk.add({
            { '[a', desc = 'Previous argument' },
            { ']a', desc = 'Next argument' },
            { '[c', desc = 'Previous class' },
            { ']c', desc = 'Next class' },
            { '[f', desc = 'Previous function' },
            { ']f', desc = 'Next function' },
        })
    end,
}
