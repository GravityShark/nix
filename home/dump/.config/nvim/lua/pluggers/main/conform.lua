return { -- conform.nvim A better formatting implementation
    'stevearc/conform.nvim',
    event = 'BufWritePre',
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
            desc = 'format',
        },
    },
    opts = {
        format = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_format = 'fallback',
        },
        formatters_by_ft = require('ensure').format,
        formatters = require('ensure').formatextra,
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
        notify_on_error = false,
    },
}
