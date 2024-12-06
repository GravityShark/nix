return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = { settings = { save_on_toggle = true } },
    keys = {
        {
            '<leader>a',
            function()
                require('harpoon'):list():add()
            end,
            desc = 'add harpoon',
        },
        {
            '<leader>m',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = 'menu harpoon',
        },
        {
            '<C-s>',
            function()
                require('harpoon'):list():select(1)
            end,
        },
        {
            '<C-t>',
            function()
                require('harpoon'):list():select(2)
            end,
        },
        {
            '<C-n>',
            function()
                require('harpoon'):list():select(3)
            end,
        },
        {
            '<C-e>',
            function()
                require('harpoon'):list():select(4)
            end,
        },
    },
}
