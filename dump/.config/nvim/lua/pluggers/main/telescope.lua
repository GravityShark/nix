return { -- telescope.nvim Fuzzy finding, but good
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
        { -- Find for a file
            '<leader>f',
            '',
            desc = '+find',
        },
        { -- Find for a file
            '<leader>ff',
            '<CMD>Telescope find_files<CR>',
            desc = 'files',
        },
        { -- Find for a file (with hidden files)
            '<leader>fa',
            '<CMD>Telescope find_files find_command=fd,--type=f,--color=never,--hidden,--no-ignore<CR>',
            desc = 'all files',
        },
        { -- Find for a directory
            '<leader>fd',
            '<CMD>Telescope find_files find_command=fd,--type=d,--color=never,--hidden,--no-ignore<CR>',
            desc = 'directories',
        },
        { -- Find for a file in git repository
            '<leader>fg',
            '<CMD>Telescope git_files<CR>',
            desc = 'git files',
        },
        {
            '<C-f>',
            '<CMD>Telescope git_files<CR>',
            noremap = false,
        },
        { -- Find text through azlive prompt
            '<leader>fl',
            '<CMD>Telescope live_grep<CR>',
            desc = 'live search',
        },
        { -- Show recent files
            '<leader>fr',
            '<CMD>Telescope oldfiles<CR>',
            desc = 'recent',
        },
        { -- Show history (previous locations)
            '<leader>fh',
            '<CMD>Telescope help_tags<CR>',
            desc = 'help tags',
        },
        { -- Show git branches
            '<leader>fb',
            '<CMD>Telescope buffers<CR>',
            desc = 'buffers',
        },
        { -- Show git branches
            '<leader>fc',
            '<CMD>Telescope git_branches<CR>',
            desc = 'checkout git branches',
        },
        { -- Show all commands
            '<leader>fp',
            '<CMD>Telescope<CR>',
            desc = 'pickers',
        },
        { -- Show all commands
            '<leader>ft',
            '<CMD>TodoTelescope<CR>',
            desc = 'todos',
        },
        { -- Show errors
            '<leader>fe',
            '<CMD>Telescope diagnostics<CR>',
            desc = 'errors',
        },
        { -- Show undos
            '<leader>fu',
            '<CMD>Telescope undo<CR>',
            desc = 'undos',
        },
        { -- Show symbols
            '<leader>fs',
            '<CMD>Telescope lsp_document_symbols<CR>',
            desc = 'symbols',
        },
        { -- Pipe word into grep
            '<leader>fw',
            function()
                local word = vim.fn.expand('<cword>')
                require('telescope.builtin').grep_string({ search = word })
            end,
            desc = 'word',
        },
        { -- Pipe word into grep
            '<leader>fW',
            function()
                local word = vim.fn.expand('<cWORD>')
                require('telescope.builtin').grep_string({ search = word })
            end,
            desc = 'WORD',
        },
        -- { -- Find for a directory
        --     '<leader>fn',
        --     '<CMD>cd ~/.config/nvim<CR><CMD>Telescope git_files<CR>',
        --     desc = 'neovim config',
        -- },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'debugloop/telescope-undo.nvim',
            config = function()
                require('telescope').load_extension('undo')
            end,
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local action_utils = require('telescope.actions.utils')
        local function single_or_multi_select(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local has_multi_selection = (
                next(current_picker:get_multi_selection()) ~= nil
            )

            if has_multi_selection then
                local results = {}
                action_utils.map_selections(prompt_bufnr, function(selection)
                    table.insert(results, selection[1])
                end)

                -- load the selections into buffers list without switching to them
                for _, filepath in ipairs(results) do
                    -- not the same as vim.fn.bufadd!
                    vim.cmd.badd({ args = { filepath } })
                end

                require('telescope.pickers').on_close_prompt(prompt_bufnr)

                -- switch to newly loaded buffers if on an empty buffer
                if vim.fn.bufname() == '' and not vim.bo.modified then
                    vim.cmd.bwipeout()
                    vim.cmd.buffer(results[1])
                end
                return
            end

            -- if does not have multi selection, open single file
            require('telescope.actions').file_edit(prompt_bufnr)
        end

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<CR>'] = single_or_multi_select,
                        ['<Tab>'] = actions.toggle_selection
                            + actions.move_selection_better,
                        ['<S-Tab>'] = actions.toggle_selection
                            + actions.move_selection_worse,
                        ['<ESC>'] = actions.close,
                    },
                },
                layout_strategy = 'bottom_pane',
                layout_config = {
                    bottom_pane = {
                        preview_width = 0.55,
                        results_width = 0.45,
                        prompt_position = 'bottom',
                    },
                },
            },
            pickers = {
                find_files = {
                    run_command = { 'fd', '--type', 'f', '--color', 'never' },
                },
            },
            extensions = {
                undo = {
                    mappings = {
                        i = {
                            ['<C-y>'] = require('telescope-undo.actions').yank_additions,
                            ['<C-S-y>'] = require('telescope-undo.actions').yank_deletions,
                            ['<CR>'] = require('telescope-undo.actions').restore,
                        },
                    },
                },
            },
        })
    end,
}
