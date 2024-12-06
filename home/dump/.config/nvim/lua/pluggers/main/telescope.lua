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
            '<CMD>Telescope find_files find_command=fd,--type=d,--color=never,--hidden,--no-ignore<CR>cd %:h',
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
        'debugloop/telescope-undo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        local select_one_or_multi = function(prompt_bufnr)
            local picker =
                require('telescope.actions.state').get_current_picker(
                    prompt_bufnr
                )
            local multi = picker:get_multi_selection()
            if not vim.tbl_isempty(multi) then
                actions.close(prompt_bufnr)
                for _, j in pairs(multi) do
                    if j.path ~= nil then
                        vim.cmd(string.format('%s %s', 'edit', j.path))
                    end
                end
            else
                actions.select_default(prompt_bufnr)
            end
        end

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<CR>'] = select_one_or_multi,
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
        telescope.load_extension('fzf')
        telescope.load_extension('undo')
    end,
}
