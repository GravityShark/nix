return { -- trouble.nvim Diagnostic Viewer
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
        {
            '<leader>ce',
            '<CMD>Trouble diagnostics toggle<CR>',
            desc = 'errors',
        },
    },
    opts = {},
}
