return { -- todo-comments.nvim Highlighted todo comments
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    keys = 'TodoTelescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
        {
            ']t',
            function()
                require('todo-comments').jump_next()
            end,
            desc = 'Next todo comment',
        },
        {
            '[t',
            function()
                require('todo-comments').jump_prev()
            end,
            desc = 'Previous todo comment',
        },
    },
}
