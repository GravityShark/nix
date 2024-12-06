return {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
    -- config = function()
    --     local pairs = require('mini.pairs')
    --     pairs.setup()
    --     vim.keymap.set('i', '<CR>', function()
    --         if
    --             vim.fn.pumvisible() ~= 0
    --             and vim.fn.complete_info().selected == -1
    --         then
    --             return pairs.cr('<C-e><CR>')
    --         end
    --         return pairs.cr()
    --     end, { silent = true, expr = true, replace_keycodes = true })
    -- end,
}
