return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
        lsp = {
            hover = {
                enabled = false,
            },
            signature = {
                enabled = false,
            },
        },
        popupmenu = {
            enabled = false,
        },
        presets = {
            bottom_search = true,
            inc_rename = true,
            lsp_doc_border = true,
        },
    },
  -- stylua: ignore
    keys = {
        { "<leader>n", "", desc = "+noice"},
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
        { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
        { "<leader>nt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
        -- { "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true, noremap = true, desc = "Scroll Forward", mode = {"i", "n", "s"}},
        -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
}
