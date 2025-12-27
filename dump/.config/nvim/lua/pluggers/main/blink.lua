return {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<C-n>'] = { 'show', 'select_next', 'fallback' },
            ['<C-j>'] = { 'snippet_forward', 'fallback' },
            ['<C-k>'] = { 'snippet_backward', 'fallback' },
        },
        -- Default preset:
        -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- ['<C-e>'] = { 'hide' },
        -- ['<C-y>'] = { 'select_and_accept' },
        -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        appearance = { nerd_font_variant = 'mono' },

        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

        -- experimental auto-brackets support
        completion = {
            trigger = {
                show_in_snippet = true,
                -- show_on_keyword = true,
                -- show_on_trigger_character = true,
                show_on_keyword = false,
                show_on_trigger_character = false,
            },
            documentation = { window = { border = 'single' } },
        },

        -- Experimental signature help support
        -- (the thing that appears if you're inside a function argument)
        signature = { enabled = true, window = { border = 'single' } },

        -- See the fuzzy documentation for more information
        fuzzy = { implementation = 'prefer_rust_with_warning' },

        cmdline = {
            enabled = true,
            keymap = {
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
            },
        },
    },

    opts_extend = { 'sources.default' },
}
