return {
    'aaronik/treewalker.nvim',
    cmd = 'Treewalker',
    keys = {
        {
            mode = { 'n', 'v' },
            '<C-k>',
            '<cmd>Treewalker Up<cr>',
            { silent = true },
        },
        {
            mode = { 'n', 'v' },
            '<C-j>',
            '<cmd>Treewalker Down<cr>',
            { silent = true },
        },
        {
            mode = { 'n', 'v' },
            '<C-h>',
            '<cmd>Treewalker Left<cr>',
            { silent = true },
        },
        {
            mode = { 'n', 'v' },
            '<C-l>',
            '<cmd>Treewalker Right<cr>',
            { silent = true },
        },
        -- Swapping
        {
            mode = 'n',
            '<C-S-k>',
            '<cmd>Treewalker SwapUp<cr>',
            { silent = true },
        },
        {
            mode = 'n',
            '<C-S-j>',
            '<cmd>Treewalker SwapDown<cr>',
            { silent = true },
        },
        {
            mode = 'n',
            '<C-S-h>',
            '<cmd>Treewalker SwapLeft<cr>',
            { silent = true },
        },
        {
            mode = 'n',
            '<C-S-l>',
            '<cmd>Treewalker SwapRight<cr>',
            { silent = true },
        },
    },
}
