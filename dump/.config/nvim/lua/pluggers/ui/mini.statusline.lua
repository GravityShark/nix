return {
    'nvim-mini/mini.statusline',
    event = 'VeryLazy',
    priority = 1000,
    dependencies = {
        'nvim-mini/mini.icons',
        opts = {},
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },
    opts = { set_vim_settings = false },
}
