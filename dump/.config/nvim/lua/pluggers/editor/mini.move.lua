return {
    'nvim-mini/mini.move',
    event = 'VeryLazy',
    keys = {
        '<C-Left>',
        '<C-Right>',
        '<C-Down>',
        '<C-Up>',
    },
    opts = {
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<C-Left>',
            right = '<C-Right>',
            down = '<C-Down>',
            up = '<C-Up>',

            -- Move current line in Normal mode
            line_left = '<C-Left>',
            line_right = '<C-Right>',
            line_down = '<C-Down>',
            line_up = '<C-Up>',
        },
    },
}
