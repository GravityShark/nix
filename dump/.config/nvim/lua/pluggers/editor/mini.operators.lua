return {
    'nvim-mini/mini.operators',
    event = 'VeryLazy',
    opts = {
        -- Evaluate text and replace with output
        evaluate = { prefix = 'g=' },

        -- Exchange text regions
        exchange = { prefix = 'gx' },

        -- Multiply (duplicate) text
        multiply = { prefix = 'gm' },

        -- Replace text with register
        replace = { prefix = 'gr' },

        -- Sort text
        sort = { prefix = 'gs' },
    },
}
