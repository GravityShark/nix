return {
    'petertriho/nvim-scrollbar',
    event = 'VeryLazy',
    dependencies = {
        'kevinhwang91/nvim-hlslens',
        'lewis6991/gitsigns.nvim',
        -- {
        --     'kevinhwang91/nvim-hlslens',
        --     config = function()
        --         require('scrollbar.handlers.search').setup({})
        --     end,
        -- },
        -- {
        --     'lewis6991/gitsigns.nvim',
        --     config = function()
        --         require('gitsigns').setup()
        --         require('scrollbar.handlers.gitsigns').setup()
        --     end,
        -- },
    },
    opts = {
        hide_if_all_visible = true,
        handle = {
            blend = 0,
            -- highlight = 'MiniStatuslineModeNormal',
        },
        marks = { Cursor = { text = '·' } },
        handlers = { gitsigns = true, search = true },
    },
}
