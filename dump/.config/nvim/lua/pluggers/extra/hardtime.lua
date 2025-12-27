return {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
        max_time = 5000,
        max_count = 2,
        timeout = 10000,
        resetting_keys = {},
        restriction_mode = 'block',
        restricted_keys = {
            ['<Left>'] = { 'n', 'i' },
            ['<Down>'] = { 'n', 'i' },
            ['<Up>'] = { 'n', 'i' },
            ['<Right>'] = { 'n', 'i' },
            ['w'] = { 'n', 'x' },
            ['W'] = { 'n', 'x' },
            ['e'] = { 'n', 'x' },
            ['E'] = { 'n', 'x' },
            ['b'] = { 'n', 'x' },
            ['B'] = { 'n', 'x' },
            -- ['J'] = { n', 'x' },
            -- ['x'] = { 'n', 'x' },
            -- ['X'] = { 'n', 'x' },
            -- ['<'] = { 'n', 'x' },
            -- ['>'] = { 'n', 'x' },
            -- ['u'] = { 'n', 'x' },
            -- [''] = { 'n', 'x' },
            ['<BS>'] = { 'i' },
        },
        -- hints = {
        --     ['%D1[webWEB]'] = {
        --         message = function()
        --             return 'Use f or t instead of spamming vro 💔'
        --         end,
        --         length = 1,
        --     },
        --
        --     ['%D1[<>]'] = {
        --         message = function()
        --             return 'Enter visual mode and spam it easier lol'
        --         end,
        --         length = 2,
        --     },
        --     ['%D1[xX]'] = {
        --         message = function()
        --             return 'Use literally any deletion motion instead of spamming ts 🥀'
        --         end,
        --         length = 1,
        --     },
        --     ['u'] = {
        --         message = function()
        --             return 'Use undotree with <leader>u instead of spamming u like a loser'
        --         end,
        --         length = 1,
        --     },
        -- },
        disabled_keys = {
            ['<C-w>c'] = { 'n' },
            ['<ESC>'] = { 'n' },
            ['<Left>'] = false,
            ['<Down>'] = false,
            ['<Up>'] = false,
            ['<Right>'] = false,
        },
    },
}
