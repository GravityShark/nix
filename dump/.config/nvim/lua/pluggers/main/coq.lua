return {
    'ms-jpq/coq_nvim',
    name = 'coq_nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    build = ':COQdeps',
    dependencies = {
        { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
        { 'ms-jpq/coq.thirdparty', branch = '3p' },
    },
    init = function()
        vim.g.coq_settings = {
            auto_start = 'shut-up', -- Silent startup
            keymap = {
                -- recommended = false,
                pre_select = true,
                manual_complete_insertion_only = true,
            },
            ['clients.snipppets.user_path'] = '$NVIM_HOME/coq-user-snippets/',
            display = {
                ['pum.y_max_len'] = 6,
                ['ghost_text.context'] = { '', '' },
                ['preview.border'] = { -- Make the preview actually diserable
                    { '', 'NormalFloat' },
                    { '', 'NormalFloat' },
                    { '', 'NormalFloat' },
                    { ' ', 'NormalFloat' },
                    { '', 'NormalFloat' },
                    { '', 'NormalFloat' },
                    { '', 'NormalFloat' },
                    { ' ', 'NormalFloat' },
                },
            },
        }
    end,
}
