return { -- mini.indentscope Indent indicators
    'nvim-mini/mini.indentscope',
    event = 'VeryLazy',
    opts = {
        -- symbol = '▎',
        -- symbol = "▏",
        symbol = '│',
        options = { try_as_border = true },
        mappings = {
            -- Textobjects
            object_scope = 'io',
            object_scope_with_border = 'ao',

            -- Motions (jump to respective border line; if not present - body line)
            goto_top = '[o',
            goto_bottom = ']o',
        },
    },
}
