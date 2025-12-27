-- Restore folds
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    pattern = { '*.*' },
    desc = 'save view (folds), when closing file',
    command = 'mkview',
})
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    pattern = { '*.*' },
    desc = 'load view (folds), when opening file',
    command = 'silent! loadview',
})
-- Highlight yank{{{
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup(
        'kickstart-highlight-yank',
        { clear = true }
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
}) -- }}}
