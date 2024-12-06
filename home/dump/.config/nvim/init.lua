-- vim.system({'./relink.out'}, {text = true, cwd = vim.fn.stdpath('config')}):wait()
-- The experimental plugin loader
vim.loader.enable()

-- Sets the settings before running lazy
require('settings')

-- Setsup lazy.nvim {{{
-- Initialize lazy.nvim {{{
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath) -- }}}
-- Setup plugins {{{
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.api.nvim_set_keymap('n', '<leader>L', '<CMD>Lazy<CR>', { desc = 'Lazy' })
require('lazy').setup({
    spec = { { import = 'pluggers' } },
    defaults = { lazy = true, version = false },
    change_detection = { notify = false },
    rocks = { enabled = false },

    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'gzip',
                'rplugin',
                'fzf',
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
                'osc52',
                -- 'man',
                -- "matchit",
                -- "matchparen",
                -- 'netrwPlugin',
                -- "shada",
            },
        },
    }, -- }}}
}) -- }}}

-- Keymaps only works after loading lazy
require('keymaps')
-- vim:foldmethod=marker:
