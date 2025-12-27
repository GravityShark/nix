return { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, --pseudo LazyFile
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = require('config.ensure').lint
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
