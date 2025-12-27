return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    keys = {
        {
            '<leader>.',
            '<CMD>Fyler kind=float<CR>',
            desc = 'file manager',
        },
        {
            '<leader>,',
            '<CMD>Fyler kind=split_left_most<CR>',
            desc = 'left tree',
        },
    },
    branch = 'stable',
    lazy = false, -- Necessary for `default_explorer` to work properly
    opts = {
        -- integrations = {
        --     icon = 'none',
        -- },
        views = {
            finder = {
                close_on_select = true,
                default_explorer = true,
                delete_to_trash = true,
            },
            mappings = {
                ['q'] = 'CloseView',
                ['<CR>'] = 'Select',
                ['<C-t>'] = 'SelectTab',
                ['|'] = 'SelectVSplit',
                -- ['-'] = 'SelectSplit',
                ['-'] = 'GotoParent',
                ['='] = 'GotoCwd',
                ['.'] = 'GotoNode',
                ['#'] = 'CollapseAll',
                ['<BS>'] = 'CollapseNode',
            },
        },
    },
}
