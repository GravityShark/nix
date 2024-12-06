return { -- gitsigns.nvim git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
        signs = {
            add = { text = '▎' },
            change = { text = '▎' },
            delete = { text = '󰐊' },
            topdelete = { text = '󰐊' },
            changedelete = { text = '▎' },
            untracked = { text = '┆' },
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            local next_hunk_repeat, prev_hunk_repeat = require(
                'nvim-treesitter.textobjects.repeatable_move'
            ).make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
            -- stylua: ignore start
            map("n", "]g", next_hunk_repeat, "Next Git Hunk")
            map("n", "[g", prev_hunk_repeat, "Previous Git Hunk")
            map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
            -- map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>gB", function() gs.blame() end, "Blame Buffer")
            map("n", "<leader>gd", gs.diffthis, "Diff This")
            map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
    },
}
