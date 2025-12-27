-- mustache template that my stylix config for nix uses

local palette = {
    base00 = '@base00@',
    base01 = '@base01@',
    base02 = '@base02@',
    base03 = '@base03@',
    base04 = '@base04@',
    base05 = '@base05@',
    base06 = '@base06@',
    base07 = '@base07@',
    base08 = '@base08@',
    base09 = '@base09@',
    base0A = '@base0A@',
    base0B = '@base0B@',
    base0C = '@base0C@',
    base0D = '@base0D@',
    base0E = '@base0E@',
    base0F = '@base0F@',
}

if palette.base00 == '@base0' .. '0@' then
    vim.api.nvim_echo({
        {
            'This colorscheme is meant to be dynamically changed by some external program (mainly nix) replace @base0'
                .. 'N@ with a proper color\n',
            'ErrorMsg',
        },
        { 'Press any key to exit', 'MoreMsg' },
    }, true, {})
    return {}
end

require('mini.base16').setup({
    palette = palette,
    use_cterm = false,
    plugins = {
        default = false,
        ['nvim-mini/mini.nvim'] = true,
        ['folke/lazy.nvim'] = true,
        ['folke/noice.nvim'] = true,
        ['folke/todo-comments.nvim'] = true,
        ['folke/trouble.nvim'] = true,
        ['folke/which-key.nvim'] = true,
        -- ['lewis6991/gitsigns.nvim'] = true,
    },
})

-- use :Inspect to check
local overrides = {
    SignColumn = { bg = 'NONE', ctermbg = 'NONE' },
    LineNr = { bg = 'NONE', ctermbg = 'NONE' },
    LineNrAbove = { bg = 'NONE', ctermbg = 'NONE' },
    LineNrBelow = { bg = 'NONE', ctermbg = 'NONE' },
    SnacksIndent = { fg = palette.base01 },
    Folded = { bg = palette.base00 },
    SpecialChar = { link = 'Special' },
    -- MiniJump = {
    --     fg = palette.base02,
    --     ctermfg = cterm.base02,
    --     undercurl = false,
    --     underline = true,
    -- },
}

-- local appends = {}
--

for hl, atr in pairs(overrides) do
    vim.api.nvim_set_hl(0, hl, atr)
end

vim.g.colors_name = 'nix'
