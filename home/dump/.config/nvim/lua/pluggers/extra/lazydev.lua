return { -- lazydev.nvim Helps in neovim development
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    config = function()
        local has_cmp = pcall(require, 'cmp')
        local has_coq = pcall(require, 'coq_nvim')
        require('lazydev').setup({
            integrations = {
                cmp = has_cmp,
                coq = has_coq,
            },
        })
    end,
}
