return {
    -- https://github.com/folke/snacks.nvim/pull/2635
    -- 'afawe3331/snacks.nvim', -- temporarily use his fork to fix images
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'OilActionsPost',
            callback = function(event)
                if event.data.actions[1].type == 'move' then
                    Snacks.rename.on_rename_file(
                        event.data.actions[1].src_url,
                        event.data.actions[1].dest_url
                    )
                end
            end,
        })
    end,
    opts = {
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = {
            enabled = true,
            matcher = { frecency = true },
            win = {
                input = {
                    keys = {
                        ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                        ['<PageUp>'] = {
                            'list_scroll_up',
                            mode = { 'i', 'n' },
                        },
                        ['<PageDown>'] = {
                            'list_scroll_down',
                            mode = { 'i', 'n' },
                        },
                    },
                },
            },
        },
        quickfile = { enabled = true },
        rename = { enabled = true },
        statuscolumn = {
            enabled = true,
            folds = {
                git_hl = true,
            },
        },

        -- words = { enabled = true }, -- it pisses all over my screen
        -- might try out debug
        -- gh, git, gitbrowse, lazygit
        -- layout
        -- notifier,notify (like nvim-notify)
    },
    keys = {
        {
            '<leader>b',
            function()
                require('snacks').bufdelete.delete()
            end,
            desc = 'buffer delete',
        },
        -- Tree View
        {
            '<leader><',
            function()
                Snacks.picker.explorer({
                    args = { '-td' },
                    layout = { auto_hide = { 'input' } },
                })
            end,
            desc = 'left file tree',
        },
        {
            '<leader>>',
            function()
                Snacks.picker.explorer({
                    args = { '-td' },
                    layout = { auto_hide = { 'input' }, position = 'right' },
                })
            end,
            desc = 'right file tree',
        },
        -- Top Pickers & Explorer
        {
            '<leader>s',
            '',
            desc = '+search',
        },
        {
            '<leader>f',
            function()
                Snacks.picker.smart({
                    multi = { 'buffers', 'git_files', 'files' },
                })
                -- local git_root =
                --     vim.fn.system(' git rev-parse --is-inside-work-tree')
                -- if vim.v.shell_error == 0 then
                --     Snacks.picker.git_files({matcher = {cwd_bonus = true}})
                -- else
                --     Snacks.picker.files({matcher = {cwd_bonus = true}})
                -- end
            end,
            desc = 'find files',
        },

        {
            '<leader>F',
            function()
                Snacks.picker.grep({ cmd = 'rg' })
            end,
            desc = 'find text',
        },
        -- find
        {
            '<leader>sb',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'buffers',
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.files({
                    title = 'Directories',
                    args = { '-td' },
                    transform = function(item)
                        local stat = vim.loop.fs_stat(item.file)
                        return stat and stat.type == 'directory' or false
                    end,
                })
            end,
            desc = 'directories',
        },
        {
            '<leader>sf',
            function()
                Snacks.picker.files()
            end,
            desc = 'files',
        },
        {
            '<leader>sg',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'git files',
        },
        -- {
        --     '<leader>fp',
        --     function()
        --         Snacks.picker.projects()
        --     end,
        --     desc = 'projects',
        -- },
        {
            '<leader>sr',
            function()
                Snacks.picker.recent()
            end,
            desc = 'recent',
        },
        -- git
        --[[
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'git branches',
        },
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'git log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'git log line',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = 'git status',
        },
        {
            '<leader>gS',
            function()
                Snacks.picker.git_stash()
            end,
            desc = 'git stash',
        },
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
            desc = 'git diff (hunks)',
        },
        {
            '<leader>gf',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'git Log File',
        },
        -- gh
        {
            '<leader>gi',
            function()
                Snacks.picker.gh_issue()
            end,
            desc = 'gitHub Issues (open)',
        },
        {
            '<leader>gI',
            function()
                Snacks.picker.gh_issue({ state = 'all' })
            end,
            desc = 'gitHub Issues (all)',
        },
        {
            '<leader>gp',
            function()
                Snacks.picker.gh_pr()
            end,
            desc = 'gitHub Pull Requests (open)',
        },
        {
            '<leader>gP',
            function()
                Snacks.picker.gh_pr({ state = 'all' })
            end,
            desc = 'gitHub Pull Requests (all)',
        },
        ]]
        --
        -- rep
        {
            '<leader>sB',
            function()
                Snacks.picker.lines()
            end,
            desc = 'Buffer lines',
        },
        -- {
        --     '<leader>sB',
        --     function()
        --         Snacks.picker.grep_buffers()
        --     end,
        --     desc = 'grep Open Buffers',
        -- },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'visual selection or word',
            mode = { 'n', 'x' },
        },
        -- search
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = 'registers',
        },
        {
            '<leader>s/',
            function()
                Snacks.picker.search_history()
            end,
            desc = 'search history',
        },
        {
            '<leader>sa',
            function()
                Snacks.picker.autocmds()
            end,
            desc = 'autocmds',
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.command_history()
            end,
            desc = 'command history',
        },
        -- {
        --     '<leader>sC',
        --     function()
        --         Snacks.picker.colorschemes()
        --     end,
        --     desc = 'Colorschemes',
        -- },
        -- {
        --     '<leader>sC',
        --     function()
        --         Snacks.picker.commands()
        --     end,
        --     desc = 'commands',
        -- },
        {
            '<leader>se',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'errors',
        },
        {
            '<leader>sD',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = 'Diagnostics (buffer)',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'help pages',
        },
        {
            '<leader>sH',
            function()
                Snacks.picker.highlights()
            end,
            desc = 'Highlights',
        },
        {
            '<leader>si',
            function()
                Snacks.picker.icons()
            end,
            desc = 'icons',
        },
        {
            '<leader>sj',
            function()
                Snacks.picker.jumps()
            end,
            desc = 'jumps',
        },
        {
            '<leader>sk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'keymaps',
        },
        {
            '<leader>sl',
            function()
                Snacks.picker.loclist()
            end,
            desc = 'location list',
        },
        {
            '<leader>sm',
            function()
                Snacks.picker.marks()
            end,
            desc = 'marks',
        },
        {
            '<leader>sM',
            function()
                Snacks.picker.man()
            end,
            desc = 'Man pages',
        },
        {
            '<leader>sp',
            function()
                Snacks.picker.lazy()
            end,
            desc = 'search for plugin spec',
        },
        {
            '<leader>sq',
            function()
                Snacks.picker.qflist()
            end,
            desc = 'quickfix list',
        },
        {
            '<leader>sR',
            function()
                Snacks.picker.resume()
            end,
            desc = 'Resume',
        },
        {
            '<leader>su',
            function()
                Snacks.picker.undo()
            end,
            desc = 'undo history',
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'symbols LSP',
        },
        {
            '<leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'symbols workspace LSP',
        },

        {
            '<leader>st',
            function()
                Snacks.picker.todo_comments()
            end,
            desc = 'todo',
        },
        {
            '<leader>sT',
            function()
                Snacks.picker.todo_comments({
                    keywords = { 'TODO', 'FIX', 'FIXME' },
                })
            end,
            desc = 'todo/fix/fixme',
        },
    },
}
