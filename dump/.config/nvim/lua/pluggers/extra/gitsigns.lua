return { -- gitsigns.nvim git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- stylua: ignore start
            map("n", "]g", gs.next_hunk, "Next Git Hunk")
            map("n", "[g", gs.prev_hunk, "Previous Git Hunk")
            map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "stage hunk")
            map({ "n", "v" }, "<leader>gr", ":Gitsigns right diffgetreset_hunk<CR>", "reset hunk")
            map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>gP", gs.preview_hunk_inline, "Preview hunk inline")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "blame line")
            map("n", "<leader>gB", function() gs.blame() end, "Blame buffer")
            map("n", "<leader>gd", gs.diffthis, "diff this")
            map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
    },
}
