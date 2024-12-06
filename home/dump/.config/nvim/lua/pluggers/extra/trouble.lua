return { -- trouble.nvim Diagnostic Viewer
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
        {
            '<leader>cx',
            '<CMD>Trouble diagnostics toggle<CR>',
            desc = 'errors',
        },
    },
    opts = {},
}
