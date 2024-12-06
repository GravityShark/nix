return { -- mini.surround Surround text with any character
    'echasnovski/mini.surround',
    keys = {
        { 'S', mode = { 'n', 'v' }, desc = 'Add surrounding' },
        -- { 'ys', desc = 'Add surrounding' },
        { 'ds', desc = 'Delete surrounding' },
        { 'cs', desc = 'Change surrounding' },
        -- { 'sf', desc = 'Find right surrounding' },
        -- { 'sF', desc = 'Find left surrounding' },
        -- { 'sh', desc = 'Highlight surrounding' },
        -- { 'sn', desc = 'Update `MiniSurround.config.n_lines`' },
    },
    opts = {
        mappings = {
            add = 'S', -- Add surrounding in Normal and Visual modes
            delete = 'ds', -- Delete surrounding
            replace = 'cs', -- Replace surrounding
        },
    },
}
