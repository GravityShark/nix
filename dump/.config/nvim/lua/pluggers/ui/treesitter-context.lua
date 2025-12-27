return { -- nvim-treesitter-context Gives you a little context on what indent you are in
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
        max_lines = 4,
        multiline_threshold = 1,
    },
}
