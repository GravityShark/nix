return {
    'nvim-mini/mini.jump',
    event = 'VeryLazy',
    opts = {
        delay = {
            highlight = 0,
        },
    },
    config = function(_, opts)
        require('mini.jump').setup(opts)

        vim.api.nvim_set_hl(0, 'MiniJump', {
            fg = vim.api.nvim_get_hl(0, { name = 'MiniJump', link = false }).fg,
            bg = vim.api.nvim_get_hl(0, { name = 'Search', link = false }).bg,
            bold = true,
            underline = true,
        })
    end,
}
