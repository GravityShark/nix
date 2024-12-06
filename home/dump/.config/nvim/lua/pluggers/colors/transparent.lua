local transparent = {
    'Normal',
    'NormalNC',
    'NormalFloat',
    'Comment',
    'Constant',
    'Special',
    'Identifier',
    'Statement',
    'PreProc',
    'Type',
    'Underlined',
    'Todo',
    'String',
    'Function',
    'Conditional',
    'Repeat',
    'Operator',
    'Structure',
    'LineNr',
    'NonText',
    'SignColumn',
    'EndOfBuffer',
    -- Plugins
    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopeSelectionCaret',
    'TelescopeMatching',
    'TelescopePromptNormal',
    'TelescopePromptTitle',
    'TelescopePromptPrefix',
    'TelescopePromptBorder',
    'TelescopePreviewTitle',
    'TelescopePreviewBorder',
    'TelescopeResultsTitle',
    'TelescopeResultsBorder',
}

-- from https://github.com/xiyaowong/transparent.nvim/blob/main/lua/transparent/init.lua
for _, v in ipairs(transparent) do
    local ok, prev_attrs = pcall(vim.api.nvim_get_hl_by_name, v, true)
    if
        ok
        and (prev_attrs.background or prev_attrs.bg or prev_attrs.ctermbg)
    then
        local attrs = vim.tbl_extend(
            'force',
            prev_attrs,
            { bg = 'NONE', ctermbg = 'NONE' }
        )
        attrs[true] = nil
        vim.api.nvim_set_hl(0, v, attrs)
    end
end
