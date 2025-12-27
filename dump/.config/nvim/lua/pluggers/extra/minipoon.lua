return {
    'kkanden/minipoon.nvim',
    keys = function()
        local keys = {
            -- { '<leader>h', '', desc = '+minipoon' },
            {
                '<leader>a',
                function()
                    require('minipoon'):add_mark()
                end,
                desc = 'add file minipoon',
            },
            {
                '<leader>m',
                function()
                    local minipoon = require('minipoon')
                    require('minipoon'):toggle_window()
                end,
                desc = 'menu minipoon',
            },
        }

        for i = 1, 9 do
            table.insert(keys, {
                '<A-' .. i .. '>',
                function()
                    require('minipoon'):open_at(i)
                end,
                desc = 'minipoon to File ' .. i,
            })
        end
        return keys
    end,
}
