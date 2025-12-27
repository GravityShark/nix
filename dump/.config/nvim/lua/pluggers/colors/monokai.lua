return {
    'tanvirtin/monokai.nvim',
    lazy = false,
    config = function()
        -- Custom palette{{{
        local paletter = {
            black = '#181a1c',
            base1 = '#252630',
            base2 = '#2b2d3a',
            base3 = '#333648',
            base4 = '#363a4e',
            base5 = '#393e53',
            base6ed = '#3f445b',
            -- base6 = '#3f445b',
            base7 = '#5a5e7a',
            pink = '#ff6188',
            white = '#e1e3e4',
            red = '#fb617e',
            orange = '#f89860',
            yellow = '#edc763',
            green = '#9ed06c',
            aqua = '#6dcae8',
            purple = '#bb97ee',
            grey = '#7e8294',
            bg_green = '#a9dc76',
            bg_blue = '#77d5f0',
            diff_add = '#394634',
            diff_remove = '#55393d',
            diff_change = '#354157',
            diff_text = '#4e432f',
            diff_purple = '#3a3446',
            diff_yellow = '#444634',
            brown = '#4e432f',
        } -- }}}

        -- List of custom highlights {{{
        local custom_hlgroupers = {
            -- Title = { fg = paletter.aqua },
            -- Constant = { fg = paletter.orange },
            -- Identifier = { fg = paletter.yellow },
            -- Statement = { fg = paletter.green },
            -- PreProc = { fg = paletter.aqua },
            -- Type = { fg = paletter.purple },
            -- Special = { fg = paletter.red },
            -- String = { fg = paletter.orange },
            ['@org.headline.level1'] = {
                fg = paletter.aqua,
                bg = paletter.diff_change,
            },
            ['@org.headline.level2'] = { fg = paletter.green },
            ['@org.headline.level3'] = { fg = paletter.purple },
            ['@org.headline.level4'] = { fg = paletter.red },
            ['@org.headline.level5'] = { fg = paletter.orange },
            ['@org.headline.level6'] = { fg = paletter.yellow },
            ['@org.headline.level7'] = { fg = paletter.bg_blue },
            ['@org.headline.level8'] = { fg = paletter.bg_green },

            ['@org.checkbox'] = { fg = paletter.green },
            ['@org.checkbox.halfchecked'] = { fg = paletter.orange },
            ['@org.checkbox.checked'] = { fg = paletter.green },
            -- ['@org.bullet'] = { fg = paletter.yellow },
            -- OrgBulletsDash = { fg = paletter.yellow },
            ['@org.drawer'] = { fg = paletter.orange },
            ['@org.plan'] = { fg = paletter.orange },
            ['@org.properties'] = { fg = paletter.pink },
            ['@org.priority.default'] = { fg = paletter.yellow },
            ['@org.priority.lowest'] = { fg = paletter.green },

            Headline1 = { bg = paletter.diff_change },
            Headline2 = { bg = paletter.diff_add },
            Headline3 = { bg = paletter.diff_purple },
            Headline4 = { bg = paletter.diff_remove },
            Headline5 = { bg = paletter.diff_text },
            Headline6 = { bg = paletter.diff_yellow },
            Headline7 = { bg = paletter.diff_change },
            Headline8 = { bg = paletter.diff_add },

            TelescopeBorder = { fg = paletter.pink },
            FloatBorder = { fg = paletter.pink },
            LineNrAbove = { fg = paletter.orange },
            LineNrBelow = { fg = paletter.orange },

            MiniTablineCurrent = {
                bg = paletter.base7,
            },
            MiniTablineVisible = {
                bg = paletter.base6ed,
            },
            MiniTablineModifiedCurrent = {
                bg = paletter.base7,
                fg = paletter.pink,
            },
            MiniTablineModifiedVisible = {
                bg = paletter.base6ed,
                fg = paletter.pink,
            },
            MiniTablineModifiedHidden = {
                fg = paletter.pink,
            },
            MiniStatuslineModeInsert = {
                fg = paletter.base1,
                bg = paletter.aqua,
            },
            MiniStatuslineModeVisual = {
                fg = paletter.base1,
                bg = paletter.purple,
            },
            MiniStatuslineModeCommand = {
                fg = paletter.white,
                bg = paletter.black,
            },
            StatusLine = {
                bg = paletter.base2,
            },
            StatusLineNC = {
                bg = paletter.base1,
            },
            FidgetTitle = { fg = paletter.pink },
            PmenuThumb = { bg = paletter.base4 },
            CursorLine = { bg = paletter.base2 },
            ColorColumn = { bg = paletter.base2 },
            MiniCursorword = { bg = '#403d52' },
        } -- }}}

        require('monokai').setup({
            palette = paletter,
            custom_hlgroups = custom_hlgroupers,
        })
    end,
}
