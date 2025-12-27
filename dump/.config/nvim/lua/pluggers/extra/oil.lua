return {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    lazy = false,
    -- event = { 'VeryLazy', 'BufNewFile' },
    keys = {
        { '<leader>,', '<CMD>Oil --float<CR>', desc = 'floating file manager' },
    },
    dependencies = {
        { 'nvim-mini/mini.icons', opts = {} },
        { 'JezerM/oil-lsp-diagnostics.nvim', opts = {} },
        {
            'benomahony/oil-git.nvim',
            init = function()
                vim.cmd('hi! link OilGitAdded GreenSign')
                vim.cmd('hi! link OilGitModified BlueSign')
                vim.cmd('hi! link OilGitRenamed PurpleSign')
                vim.cmd('hi! link OilGitUntracked GreenSign')
                vim.cmd('hi! link OilGitIgnored Grey')
            end,
        },
    },

    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        lsp_file_methods = { autosave_changes = true },
        watch_for_changes = true,
        view_options = {
            sort = {
                { 'type', 'desc' },
                { 'mtime', 'desc' },
            },
        },
        preview_win = { preview_method = 'scratch' },
        keymaps = {
            ['<ESC>'] = { 'actions.close', mode = 'n' },
            ['<S-CR>'] = { 'actions.open_external', mode = 'n' },
            ['gp'] = { 'actions.preview', mode = 'n' },
            ['gd'] = {
                desc = 'Toggle file detail view',
                callback = function()
                    detail = not detail
                    if detail then
                        require('oil').set_columns({
                            'icon',
                            'permissions',
                            'size',
                            'mtime',
                        })
                    else
                        require('oil').set_columns({ 'icon' })
                    end
                end,
            },
            [';'] = {
                'actions.open_cmdline',
                opts = {
                    shorten_path = true,
                    -- modify = ':h',
                },
            },
            ['"'] = {
                'actions.open_cmdline',
                opts = {
                    shorten_path = true,
                    modify = ':h',
                },
            },
        },
        float = { border = 'rounded' },
    },
}
