-- return {
--     'williamboman/mason.nvim',
--     cmd = 'Mason',
--     opts = {},
-- }
return { -- mason-tool-installer.nvim Easy installation of LSPs
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        opts = {},
    },
    event = 'VeryLazy',
    cmd = { 'MasonToolsUpdate', 'MasonToolsInstall' },
    opts = {
        ensure_installed = require('ensure').mason,
        auto_update = true,
    },
}
