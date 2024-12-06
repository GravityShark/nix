-- I do not recommend to touch
return { -- LSP Configuration (compatible with cmp, coq, and even neither!)
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    init = function()
        for type, icon in pairs({
            Error = ' ',
            Warn = ' ',
            Hint = '󰌵 ',
            Info = '󰋼 ',
        }) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
        vim.diagnostic.config({
            update_in_insert = true,
        })
    end,
    config = function()
        -- Keybindings to set when LSP has attached
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Keybindings
                vim.keymap.set(
                    'n',
                    '<leader>cD',
                    vim.lsp.buf.declaration,
                    { buffer = ev.buf, desc = 'declaration' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>cd',
                    vim.lsp.buf.definition,
                    { buffer = ev.buf, desc = 'definition' }
                )
                vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition, {
                    buffer = ev.buf,
                    desc = 'type definition',
                })
                vim.keymap.set(
                    'n',
                    '<leader>cc',
                    vim.lsp.buf.code_action,
                    { buffer = ev.buf, desc = 'code actions' }
                )
                vim.keymap.set('n', '<leader>cm', vim.lsp.buf.references, {
                    buffer = ev.buf,
                    desc = 'mentions',
                })

                local ok = pcall(require, 'inc_rename')
                if ok then
                    vim.keymap.set('n', '<leader>cr', function()
                        return ':IncRename ' .. vim.fn.expand('<cword>')
                    end, { expr = true, desc = 'rename' })
                else
                    vim.keymap.set(
                        'n',
                        '<leader>cr',
                        vim.lsp.buf.rename,
                        { buffer = ev.buf, desc = 'rename' }
                    )
                end

                vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, {
                    buffer = ev.buf,
                    desc = 'implementation',
                })

                vim.keymap.set(
                    'n',
                    '<leader>cp',
                    vim.diagnostic.open_float,
                    { desc = 'popup diagnostic' }
                )
                vim.keymap.set('n', '<leader>cw', function()
                    vim.lsp.buf.workspace_symbol()
                end, {
                    desc = 'workspace symbol',
                    buffer = ev.buf,
                })
            end,
        })

        pcall(require, 'mason')
        local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        local has_coq, coq = pcall(require, 'coq_nvim')
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            has_cmp and cmp_nvim_lsp.default_capabilities() or {}
        )

        -- Server setup
        for server_name, server in pairs(require('ensure').lsp) do
            server.capabilities = vim.tbl_deep_extend(
                'force',
                {},
                capabilities,
                server.capabilities or {}
            )

            if has_coq then
                server = coq.lsp_ensure_capabilities(server)
            end
            require('lspconfig')[server_name].setup(server)
        end
    end,
}
