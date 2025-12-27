-- Sets the settings before running lazy
require('config.options')

-- Setsup lazy.nvim {{{
-- Bootstrap lazy.nvim {{{
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
    spec = { { import = 'enabled' } },
    defaults = { lazy = true, version = false },
    change_detection = { notify = false },
    rocks = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'fzf',
                'gzip',
                -- 'man',
                -- "matchit",
                -- "matchparen",
                'netrwPlugin',
                'osc52',
                'rplugin',
                -- "shada",
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    }, -- }}}
}) -- }}}

-- Keymaps only works after loading lazy
require('config.autocmds')
require('config.foldtext')
require('config.keymaps')
-- require('config.transparent')
-- vim:foldmethod=marker:
