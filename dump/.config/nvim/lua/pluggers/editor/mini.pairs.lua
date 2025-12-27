return {
    'nvim-mini/mini.pairs',
    event = 'VeryLazy',
    opts = {},
    -- opts = {
    --     modes = { insert = true, command = true, terminal = false },
    --     -- skip autopair when next character is one of these
    --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    --     -- skip autopair when the cursor is inside these treesitter nodes
    --     skip_ts = { 'string' },
    --     -- skip autopair when next character is closing pair
    --     -- and there are more closing pairs than opening pairs
    --     skip_unbalanced = true,
    --     -- better deal with markdown code blocks
    --     markdown = true,
    -- },
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
