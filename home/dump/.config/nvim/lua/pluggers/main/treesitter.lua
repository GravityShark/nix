return { -- nvim-treesitter Supercharge syntax editing
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = require('ensure').treesitter,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<enter>',
                    node_incremental = '<enter>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']c'] = '@class.outer',
                        [']a'] = '@parameter.inner',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[c'] = '@class.outer',
                        ['[a'] = '@parameter.inner',
                    },
                },
            },
        })

        local ts_repeat_move =
            require('nvim-treesitter.textobjects.repeatable_move')
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move)

        -- make sure forward function comes first
        local next_buf_repeat, prev_buf_repeat =
            ts_repeat_move.make_repeatable_move_pair(
                vim.cmd.bnext,
                vim.cmd.bprevious
            )
        local next_c_repeat, prev_c_repeat =
            ts_repeat_move.make_repeatable_move_pair(
                vim.cmd.cnext,
                vim.cmd.cprev
            )

        vim.keymap.set('n', '[b', prev_buf_repeat, { desc = 'Previous buffer' })
        vim.keymap.set('n', ']b', next_buf_repeat, { desc = 'Next buffer' })
        vim.keymap.set('n', '[q', prev_c_repeat, { desc = 'Previous quickfix' })
        vim.keymap.set('n', ']q', next_c_repeat, { desc = 'Next quickfix' })
    end,
}
