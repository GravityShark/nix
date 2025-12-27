-- Plugin remaps are located in the respective plugin definition
-- under their keys map

-- Groups
vim.api.nvim_set_keymap('n', '<leader>c', '', { desc = '+code' })

-- Terminal helpers {{{
-- To escape terminal mode
vim.api.nvim_set_keymap('t', '<C-space>', '<C-\\><C-n>', { silent = true })
-- Enter terminal
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>s',
--     '<CMD>split term://$SHELL<CR><CMD>set nu!<CR><CMD>set rnu!<CR>i',
--     { desc = 'shell' }
-- )
-- }}}

-- Run/Compile code inside {{{
-- Saved compile arguments are stolen from here
-- https://github.com/xiyaowong/transparent.nvim/blob/b075d5bb07fa1615b09585e1a2f7d2418c251562/lua/transparent/cache.lua
vim.keymap.set('n', '<leader>r', function()
    -- Check if cache folder exists, if it doesn't create it
    local cache_dir = vim.fn.stdpath('data') .. '/compile/'
    if vim.fn.isdirectory(cache_dir) == 0 then
        vim.fn.mkdir(cache_dir, 'p')
    end

    -- Try to read the saved command for the file, ignores if doesn't exist
    local file = vim.api.nvim_buf_get_name(0)
    local path = cache_dir .. file:gsub('/', '@')
    local exists, lines = pcall(vim.fn.readfile, path)
    if exists and #lines > 0 then
        vim.b.runwithparameters = lines[1]
    end

    -- Prompt
    vim.ui.input({
        prompt = 'Run: ',
        default = vim.b.runwithparameters,
        completion = 'shellcmdline',
    }, function(input)
        if input == nil or input == '' then
            print(
                'See :h cmdline-special, :h filename-modifiers, and :h c_CTRL-F'
            )
            return
        end

        -- Set the saved parameters as input
        vim.b.runwithparameters = input
        -- Write the new saved parameters to the cache
        vim.fn.writefile({ input }, path)
        -- Run the command
        vim.cmd(
            'split | lcd '
                .. vim.fn.fnamemodify(file, ':p:h')
                .. ' | terminal '
                .. input
        )
        vim.cmd.startinsert()
    end)
end, { desc = 'run command' })

vim.keymap.set('n', '<leader>R', function()
    -- Check if cache folder exists, if it doesn't create it
    local cache_dir = vim.fn.stdpath('data') .. '/compile/'
    if vim.fn.isdirectory(cache_dir) == 0 then
        vim.fn.mkdir(cache_dir, 'p')
    end

    -- Either cwd or git root
    local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    local cwd
    if vim.v.shell_error ~= 0 or git_root == nil or git_root == '' then
        cwd = vim.fn.getcwd()
    else
        cwd = git_root
    end

    -- Try to read the saved command for the project directory, ignores if doesn't exist
    local path = cache_dir .. cwd:gsub('/', '@')
    local exists, lines = pcall(vim.fn.readfile, path)
    if exists and #lines > 0 then
        vim.g.runwithparametersglobally = lines[1]
    end

    -- Prompt
    vim.ui.input({
        prompt = 'Run (Project): ',
        default = vim.g.runwithparametersglobally,
        completion = 'shellcmdline',
    }, function(input)
        if input == nil or input == '' then
            print(
                'See :h cmdline-special, :h filename-modifiers, and :h c_CTRL-F'
            )
            return
        end
        -- Set the saved parameters as input
        vim.g.runwithparametersglobally = input
        -- Write the new saved parameters to the cache
        vim.fn.writefile({ input }, path)
        -- Run the command
        vim.cmd('split | lcd ' .. cwd .. ' | terminal ' .. input)
        vim.cmd.startinsert()
    end)
end, { desc = 'Run command per project' })
--}}}

-- Save, close and quit bindings {{{
vim.api.nvim_set_keymap(
    'n',
    '<leader>w',
    '<CMD>w<CR>',
    { silent = true, desc = 'write current buffer' }
)
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>W',
--     '<CMD>wa<CR>',
--     { silent = true, desc = 'Write all buffers' }
-- )
-- Use ZZ instead
vim.api.nvim_set_keymap(
    'n',
    '<leader>q',
    '<CMD>wq<CR>',
    { silent = true, desc = 'quit with saving' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>Q',
    '<CMD>qa!<CR>',
    { silent = true, desc = 'Quit forcefully' }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>x',
    '<CMD>close<CR>',
    { desc = 'close window' }
)

-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>X',
--     '<CMD>bdelete!<CR>',
--     { desc = 'close buffer forcefully' }
-- )
-- }}}

-- Allow for using the script ~t~ inside nvim {{{
-- vim.api.nvim_set_keymap('n', '<C-g>', '<CMD>silent !t<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<A-g>', '<CMD>silent !T<CR>', { silent = true })
-- }}}

-- Visual mode indents reenters visual mode {{{
vim.api.nvim_set_keymap('v', '>', '> gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '< gv', { noremap = true })
-- }}}

-- <leader>[y|p|P] uses to system clipboard, and <leader>d to delete without copying{{{
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'delete void' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'yank clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p"', { desc = 'paste clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste clipboard' }) -- }}}

-- Middle positioned C+[D/U] and [n/N] {{{
vim.keymap.set(
    { 'n', 'v' },
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'v' },
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true }
)

vim.keymap.set(
    { 'n', 'v' },
    '<PageDown>',
    '<C-d>zz',
    { noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'v' },
    '<PageUp>',
    '<C-u>zz',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { silent = true })
-- }}}

-- Netrw {{{
-- Open netrw on the left as nerdtree
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>>',
--     '<CMD>Lex<CR>iii',
--     { desc = 'nerdtree' }
-- )

-- Open current window as default file manager
vim.api.nvim_set_keymap(
    'n',
    '<leader>.',
    '<CMD>edit %:p:h<CR>',
    { desc = 'file explorer' }
)

-- Open a floating window with netrw
-- vim.keymap.set('n', '<leader>.', function()
--     require('floating_netrw').toggle()
-- end, { desc = 'file explorer', noremap = true, silent = true })

-- }}}

-- blazingly fast https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua {{{
-- greatest remap ever
-- }}}

-- square bracket motions {{{
vim.api.nvim_set_keymap(
    'n',
    '[b',
    '<CMD>bprev<CR>',
    { desc = 'Previous buffer' }
)
vim.api.nvim_set_keymap('n', ']b', '<CMD>bnext<CR>', { desc = 'Next buffer' })
vim.api.nvim_set_keymap(
    'n',
    '[q',
    '<CMD>cprev<CR>zz',
    { desc = 'Previous quickfix' }
)
vim.api.nvim_set_keymap(
    'n',
    ']q',
    '<CMD>cnext<CR>zz',
    { desc = 'Next quickfix' }
)

-- }}}

-- plus and minus for decrement and increment {{{
-- vim.api.nvim_set_keymap('n', '+', '<C-a>', { desc = 'Increment' })
-- vim.api.nvim_set_keymap('n', '-', '<C-x>', { desc = 'Decrement' })
-- }}}
-- vim:foldmethod=marker:
