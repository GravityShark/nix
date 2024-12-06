-- Opts {{{
vim.opt.laststatus = 3 -- Global statusline
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Fire line
vim.opt.updatetime = 50 -- Faster faster faster
vim.opt.conceallevel = 3 -- Hide characters by treesitter
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.matchtime = 0 -- disable that weird effect with matching parens
vim.opt.scrolloff = 8 -- Leaves 8 lines of extra space
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Better completion
vim.opt.pumheight = 10 -- Max completion height
vim.opt.colorcolumn = '80' -- Ruler
vim.opt.breakindent = true
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.shiftwidth = 8 -- Set amount of space characters when using "<" or ">"
vim.opt.softtabstop = 8
vim.opt.tabstop = 8 -- 1 tab equal 8 spaces
vim.opt.smartindent = true
vim.opt.ignorecase = true -- Ignore case if all characters in lower case
vim.opt.smartcase = true -- When there is a one capital letter search for exact match
vim.opt.showmatch = true -- Highlight search instances
vim.opt.showmode = false -- Disable showing current mode in cmdline
vim.g.have_nerd_font = true -- Enable nerd fonts
vim.opt.termguicolors = true -- The colors become good
-- Folding
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- Netrw
vim.g.netrw_bufsettings = 'noma nomod nowrap ro nobl rnu'
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
-- mini.basics
vim.opt.splitbelow = true -- when the splits are good
vim.opt.splitright = true
vim.opt.writebackup = false -- idk
vim.opt.linebreak = true
vim.opt.ruler = false
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.infercase = true
vim.opt.virtualedit = 'block' -- Allows visual block to go anywhere
vim.opt.formatoptions = 'qjl1'
-- }}}
-- Highlight yank{{{
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup(
        'kickstart-highlight-yank',
        { clear = true }
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
}) -- }}}
-- vim:foldmethod=marker:
