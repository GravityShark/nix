return { -- soho vibes
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd('colorscheme rose-pine-main')
        -- vim.cmd('colorscheme rose-pine-dawn')
    end,
    opts = {
        highlight_groups = {
            Folded = { bg = 'base' },
            MiniJump = { fg = 'subtle', undercurl = false, underline = true },
        },
    },
}
