return { -- Default LSP Configurations
    'neovim/nvim-lspconfig',
    init = function()
        vim.diagnostic.config({
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = 'if_many',
                prefix = '●',
                -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                -- prefix = "icons",
            },
            severity_sort = true,
            underline = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = ' ',
                    [vim.diagnostic.severity.WARN] = ' ',
                    [vim.diagnostic.severity.HINT] = '󰌵 ',
                    [vim.diagnostic.severity.INFO] = '󰋼 ',
                },
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Keybindings
                vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, {
                    buffer = ev.buf,
                    desc = 'lens',
                })
                vim.keymap.set('n', '<leader>ci', function()
                    vim.lsp.inlay_hint.enable(
                        not vim.lsp.inlay_hint.is_enabled()
                    )
                end, {
                    desc = 'inlay hints',
                })

                vim.keymap.set(
                    'n',
                    '<leader>cc',
                    vim.lsp.buf.code_action,
                    { buffer = ev.buf, desc = 'code actions' }
                )

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
                vim.keymap.set(
                    'n',
                    '[e',
                    vim.diagnostic.goto_prev,
                    { desc = 'error' }
                )
                vim.keymap.set(
                    'n',
                    ']e',
                    vim.diagnostic.goto_next,
                    { desc = 'error' }
                )

                -- Plugins
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

                local snacks = pcall(require, 'snacks')
                -- {
                --     'gai',
                --     function()
                --         Snacks.picker.lsp_incoming_calls()
                --     end,
                --     desc = 'C[a]lls Incoming',
                -- },
                -- {
                --     'gao',
                --     function()
                --         Snacks.picker.lsp_outgoing_calls()
                --     end,
                --     desc = 'C[a]lls Outgoing',
                -- },
                if snacks then
                    vim.keymap.set('n', 'gd', function()
                        require('snacks').picker.lsp_definitions()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to definition',
                    })
                    vim.keymap.set('n', 'gD', function()
                        require('snacks').picker.lsp_declarations()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to declaration',
                    })

                    vim.keymap.set('n', 'gr', function()
                        require('snacks').picker.lsp_references()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to references',
                    })
                    vim.keymap.set('n', 'gI', function()
                        require('snacks').picker.lsp_implementations()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to implementation',
                    })
                    vim.keymap.set('n', 'gy', function()
                        require('snacks').picker.lsp_type_definitions()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to t[y]pe definition',
                    })
                    vim.keymap.set('n', 'gy', function()
                        require('snacks').picker.lsp_type_definitions()
                    end, {
                        buffer = ev.buf,
                        desc = 'go to t[y]pe definition',
                    })
                else
                    vim.keymap.set(
                        'n',
                        'gd',
                        vim.lsp.buf.definition,
                        { buffer = ev.buf, desc = 'go to definition' }
                    )
                    vim.keymap.set(
                        'n',
                        'gD',
                        vim.lsp.buf.declaration,
                        { buffer = ev.buf, desc = 'go to declaration' }
                    )
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {
                        buffer = ev.buf,
                        desc = 'go to references',
                    })
                    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, {
                        buffer = ev.buf,
                        desc = 'go to implementation',
                    })

                    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {
                        buffer = ev.buf,
                        desc = 'go to t[y]pe definition',
                    })
                end
                -- LSP
            end,
        })
    end,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    config = function()
        for key, val in pairs(require('config.ensure').lsp) do
            if type(val) == 'table' then
                vim.lsp.enable(key)
                vim.lsp.config(key, val)
            else
                vim.lsp.enable(val)
            end
        end
    end,
}
