-- A single file listing Treesitter, LSP, Formatting and Linting specs.
M = {}

-- Mostly want to install parsers that don't automatically install by filename
M.treesitter = {
    'diff',
    'gitcommit',
    'markdown_inline',
    'printf',
    'query',
    'regex',
}

M.lsp = { -- :help lspconfig-all
    'clangd',
    'pyright',
    gopls = {
        settings = {
            gopls = {
                usePlaceholders = true,
                analyses = { unusedparams = true },
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = { autoRequire = true, callSnippet = 'Replace' },
                workspace = { checkThirdParty = false },
                hint = { enable = true },
            },
        },
    },
    nil_ls = { settings = { nix = { flake = { autoArchive = true } } } },
    -- Webdev
    'emmet_language_server',
    'html',
    'jsonls',
    'tailwindcss',
    ts_ls = {
        settings = { implicitProjectConfiguration = { checkJs = true } },
    },
}

M.format = { -- :help conform-formatters
    bash = { 'shfmt' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    go = { 'gofumpt', 'golines', 'goimports-reviser' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    nix = { 'nixfmt' },
    ocaml = { 'ocamlformat' },
    python = { 'ruff_format' },
    ruby = { 'rubyfmt' },
    sh = { 'shfmt' },
    swift = { 'swift-format' },
    yaml = { 'prettierd' },
    -- Web dev
    html = { 'prettierd' },
    css = { 'prettierd' },
    javascript = { 'prettierd' },
    json = { 'prettierd' },
}

M.formatextra = { -- :help conform-options
    ruff = {
        prepend_args = { '--config', '~/.ruff.toml' },
    },
}

-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters or
M.lint = { -- :e ~/.local/share/nvim/lazy/nvim-lint/lua/lint/linters
    python = { 'ruff' },
    javascript = { 'quick-lint-js' },
    go = { 'golangcilint' },
}

-- If you use mason like a fat lolcow then use this and enable mason
-- M.mason = { }

return M
