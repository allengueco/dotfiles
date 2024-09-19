return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:nvim-java/mason-registry",
            },
            ui = {
                border = 'rounded'
            }
        }
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    { 'ray-x/lsp_signature.nvim', event = 'VeryLazy' },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = { 'L3MON4D3/LuaSnip', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'onsails/lspkind.nvim' },
        config = function()
            -- Configure autocomplete
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local lspkind = require('lspkind')

            local luasnip = require('luasnip')
            luasnip.filetype_extend('typescript', { 'angular' })
            luasnip.filetype_extend('html', { 'angular' })
            luasnip.filetype_extend('htmlangular', { 'angular' })
            require('luasnip.loaders.from_vscode').lazy_load()
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                    })
                }
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'ray-x/lsp_signature.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            local lsp_attach = function(client, bufnr)
                require('lsp_signature').on_attach({
                    bind = true,
                    handler_opts = {
                        border = 'rounded'
                    }
                })
                lsp_zero.highlight_symbol(client, bufnr)
                lsp_zero.buffer_autoformat()
                lsp_zero.default_keymaps({ buffer = bufnr })
            end

            lsp_zero.extend_lspconfig({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                lsp_attach = lsp_attach,
                float_border = 'rounded',
                sign_text = {
                    warn = '▲',
                    hint = '⚑',
                    info = '»',
                    error = '✘',
                },
            })

            require('mason-lspconfig').setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                ensure_installed = { 'angularls', 'html', 'ts_ls', 'rust_analyzer', 'jdtls', 'lua_ls', 'marksman' },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    -- Configured with jdtls.lua
                    jdtls = function() end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup {
                            on_init = function(client)
                                lsp_zero.nvim_lua_settings(client, {})
                            end
                        }
                    end,
                    ltex = function()
                        require('lspconfig').ltex.setup {
                            filetypes = {
                                "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "text"
                            }
                        }
                    end,
                }
            })
        end
    }
}
