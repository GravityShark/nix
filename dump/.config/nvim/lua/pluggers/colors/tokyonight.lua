return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('tokyonight-day')
    end,
    opts = {
        style = 'moon',
        on_highlights = function(hl, c)
            hl.LineNr = {
                fg = c.fg,
            }
            hl.LineNrBelow = {
                fg = c.fg,
            }
            hl.LineNrAbove = {
                fg = c.fg,
            }
        end,
    },
}
