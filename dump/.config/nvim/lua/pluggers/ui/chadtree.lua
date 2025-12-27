return {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = ':CHADdeps',
    cmd = 'CHADopen',
    keys = {
        {
            '<leader>,',
            '<CMD>CHADopen --nofocus<CR>',
            desc = 'CHADtree',
        },
    },
    -- init = function()
    --     vim.g.chadtree_settings =
    --         { ['view.width'] = 40, ['options.close_on_open'] = true }
    -- end,
}
