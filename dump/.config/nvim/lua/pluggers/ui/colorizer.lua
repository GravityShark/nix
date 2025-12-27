return { -- colorizer.nvim Visualize color codes in code
    'catgoose/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
    event = 'VeryLazy',
    keys = {
        {
            '<leader>ch',
            '<CMD>ColorizerToggle<CR><CMD>ColorizerReloadAllBuffers<CR>',
            desc = 'highlight colors',
        },
    },
    opts = {
        lazy_load = true,
        user_default_options = {
            names = false,
            css = true,
            tailwind = true,
            mode = 'virtualtext',
            virtualtext = '󱓻',
            virtualtext_inline = 'before',
        },
    },
}
