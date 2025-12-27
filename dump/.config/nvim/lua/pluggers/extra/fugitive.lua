return { -- vise for going to the git repository in a browser
    'tpope/vim-fugitive',
    keys = {
        {
            '<leader>g',
            '',
            desc = '+git',
        },
        {
            '<leader>gm',
            '<CMD>Git<CR><C-w>L',
            desc = 'menu',
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
            '<leader>gM',
            '<CMD>Git mergetool<CR>',
            desc = 'mergetool',
        },
        {
            '<leader>gv',
            '<CMD>Gvdiffsplit!<CR>',
            desc = 'vertical diff split',
        },
        {
            '<leader>gh',
            '<CMD>Ghdiffsplit!<CR>',
            desc = 'horizontal diff split',
        },
        {
            'gh',
            '<CMD>diffget //2<CR>',
            desc = 'get diff left',
            noremap = true,
        },
        {
            'gl',
            '<CMD>diffget //3<CR>',
            desc = 'get diff right',
            noremap = true,
        },
    },
    cmd = { 'Git', 'Gvdiffsplit', 'Ghdiffsplit' },
    dependencies = {
        { -- vim-fugitive :Git for an integrated git experience with vim
            'tpope/vim-rhubarb',
            cmd = 'GBrowse',
        },
    },
}
