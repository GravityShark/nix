return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
        cmdline = {
            format = {
                -- to prevent smear-cursor.nvim from fucking up
                filter = { conceal = false },
                lua = { conceal = false },
                help = { conceal = false },
                input = { conceal = false },
                cmdline = { conceal = false },
            },
        },
        inc_rename = {
            cmdline = {
                format = {
                    IncRename = { conceal = false },
                },
            },
        },
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    any = {
                        { find = '%d+L, %d+B' },
                        { find = '; after #%d+' },
                        { find = '; before #%d+' },
                    },
                },
                view = 'mini',
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
        },
        -- lsp = {
        --     hover = {
        --         enabled = false,
        --     },
        --     signature = {
        --         enabled = false,
        --     },
        -- },
        -- popupmenu = {
        --     enabled = false,
        -- },
        -- presets = {
        --     bottom_search = true,
        --     inc_rename = true,
        --     lsp_doc_border = true,
        -- },
    },
  -- stylua: ignore
    keys = {
        { "<leader>n", "", desc = "+noice"},
        -- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        { "<leader>nl", function() require("noice").cmd("last") end, desc = "noice last message" },
        { "<leader>nh", function() require("noice").cmd("history") end, desc = "noice history" },
        { "<leader>na", function() require("noice").cmd("all") end, desc = "noice all" },
        { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "dismiss all" },
        { "<leader>ne", function() require("noice").cmd("error") end, desc = "noice all" },
        { '<leader>np', function() Snacks.picker.notifications() end, desc = 'picker' },
        -- { "<leader>nt", function() require("noice").cmd("pick") end, desc = "noice picker (telescope/FzfLua)" },
        -- { "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true, noremap = true, desc = "Scroll Forward", mode = {"i", "n", "s"}},
        -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
}
