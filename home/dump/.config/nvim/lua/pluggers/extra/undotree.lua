return { -- undotree Shows a tree, of your undos
    'mbbill/undotree',
    init = function()
        -- Undotree Layout
        --g:undotree_WindowLayout = 1
        vim.g.undotree_DiffAutoOpen = false
        vim.g.undotree_WindowLayout = 3
    end,
    cmd = { 'UndotreeToggle', 'UndotreeFocus' },
    keys = {
        {
            '<leader>u',
            '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<CR>',
            desc = 'undotree',
        },
    },
}
