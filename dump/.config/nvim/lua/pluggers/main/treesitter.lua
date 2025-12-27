return { -- nvim-treesitter Supercharge syntax editing
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    -- dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = require('config.ensure').treesitter,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<enter>',
                    node_incremental = false,
                    scope_incremental = '<enter>',
                    node_decremental = '<bs>',
                },
            },
            -- textobjects = {
            --     move = {
            --         enable = true,
            --         goto_next_start = {
            --             [']f'] = '@function.outer',
            --             [']c'] = '@class.outer',
            --             [']a'] = '@parameter.inner',
            --         },
            --         goto_previous_start = {
            --             ['[f'] = '@function.outer',
            --             ['[c'] = '@class.outer',
            --             ['[a'] = '@parameter.inner',
            --         },
            --     },
            -- },
        })
    end,
}
