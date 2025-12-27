return {
    'otavioschwanck/arrow.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {
        show_icons = true,
        always_show_path = true,
        -- hide_handbook = true,
        -- hide_buffer_handbook = true,
        leader_key = 'm',
        buffer_leader_key = ',',
        save_key = 'git_root',
        mappings = {
            toggle = ' ', -- <- this is a space btw
            delete_mode = 'k',
        },
        per_buffer_config = {
            lines = 1,
        },
    },
}
