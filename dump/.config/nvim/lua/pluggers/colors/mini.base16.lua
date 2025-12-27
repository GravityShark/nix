return {
    'nvim-mini/mini.base16',
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('nix')
    end,
}
