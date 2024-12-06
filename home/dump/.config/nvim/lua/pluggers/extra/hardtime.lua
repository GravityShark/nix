return {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
        max_time = 3000,
        disabled_keys = {
            ['<C-w>c'] = { 'n' },
        },
    },
}
