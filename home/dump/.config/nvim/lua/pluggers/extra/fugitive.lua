return { -- vise for going to the git repository in a browser
    'tpope/vim-rhubarb',
    cmd = 'GBrowse',
    dependencies = { -- vim-fugitive :Git for an integrated git experience with vim
        'tpope/vim-fugitive',
        keys = {
            {
                '<leader>g',
                '',
                desc = '+git',
            },
            {
                '<leader>gm',
                '<CMD>Git<CR>',
                desc = 'MEnu',
            },
            {
                '<leader>gc',
                '<CMD>Git show<CR>',
                desc = 'changes',
            },
            {
                '<leader>gp',
                '<CMD>Git push<CR>',
                desc = 'push',
            },
            {
                'gt',
                '<CMD>diffget //2<CR>',
                { desc = 'diffget //2', noremap = true },
            },
            {
                'gn',
                '<CMD>diffget //3<CR>',
                { desc = 'diffget //3', noremap = true },
            },
        },
        cmd = { 'Git' },
    },
}
