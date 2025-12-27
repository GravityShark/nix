return {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>nn',
            function()
                require('notify').dismiss({ silent = true, pending = true })
            end,
            desc = 'Dismiss All Notifications',
        },
    },
    opts = {
        stages = 'static',
        top_down = false,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
    },
}
