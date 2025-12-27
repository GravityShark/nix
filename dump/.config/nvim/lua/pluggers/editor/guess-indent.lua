return { -- guess-indent.nvim Automatically guess the indent level
    'nmac427/guess-indent.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = { { '<Leader>cg', '<CMD>GuessIndent<CR>', desc = 'guess indent' } },
    cmd = 'GuessIndent',
    opts = {},
}
