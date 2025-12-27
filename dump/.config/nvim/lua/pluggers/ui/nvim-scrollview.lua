return {
    'dstein64/nvim-scrollview',
    event = 'VeryLazy',
    opts = function()
        require('scrollview.contrib.gitsigns').setup({})
        return {}
    end,
}
