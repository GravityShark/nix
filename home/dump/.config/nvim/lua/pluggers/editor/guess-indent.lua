return { -- guess-indent.nvim Automatically guess the indent level
    'nmac427/guess-indent.nvim',
    opts = {},
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
}
