return { -- conform.nvim A better formatting implementation
    'stevearc/conform.nvim',
    event = { 'VeryLazy', 'BufWritePre' },
    cmd = { 'ConformInfo' },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format()
            end,
            mode = { 'n', 'v' },
            desc = 'format',
        },
        {
            '<leader>cF',
            function()
                vim.b.disable_autoformat = not vim.b.disable_autoformat
            end,
            mode = { 'n', 'v' },
            desc = 'Format on save, toggle for buffer',
        },
    },
    opts = {
        format = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_format = 'fallback',
        },
        formatters_by_ft = require('config.ensure').format,
        formatters = require('config.ensure').formatextra,
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
        notify_on_error = false,
    },
}
