return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:nvim-java/mason-registry",
            },
        },
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local luasnip = require("luasnip")
            luasnip.filetype_extend("typescript", { "angular" })
            luasnip.filetype_extend("html", { "angular" })
            luasnip.filetype_extend("htmlangular", { "angular" })
        end,
    },
    {
        -- NOTE: switch when jdtls is supported
        "saghen/blink.cmp",
        lazy = false,
        -- enabled = false,
        commit = "ffc428208f292fa00cb7cced09d35de6e815ab55",
        dependencies = { "rafamadriz/friendly-snippets" },
        -- version = "v0.*",
        opts = {
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            sources = {
                providers = {
                    {
                        "blink.cmp.sources.snippets",
                        name = "Snippets",
                        opts = {
                            extended_filetypes = {
                                typescript = { "angular" },
                                html = { "angular" },
                                htmlangular = { "angular" },
                            }
                        }
                    }
                },
            },
            nerd_font_variant = "mono",
            keymap = {
                show = '<C-Space>',
                hide = '<C-e>',
                accept = '<CR>',
                show_documentation = '<C-Space>',
                hide_documentation = '<C-Space>',
                scroll_documentation_up = '<C-u>',
                scroll_documentation_down = '<C-d>',
                snippet_forward = '<Tab>',
                snippet_backward = '<S-Tab>',
            },
            accept = {
                auto_brackets = {
                    enabled = true
                }
            }
        }
    },
    -- {
    --     -- "hrsh7th/nvim-cmp",
    --     "yioneko/nvim-cmp",
    --     branch = "perf",
    --     enabled = false,
    --     event = "InsertEnter",
    --     dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind.nvim" },
    --     config = function()
    --         -- Configure autocomplete
    --         local lsp_zero = require("lsp-zero")
    --         lsp_zero.extend_cmp()
    --
    --         local cmp = require("cmp")
    --         local cmp_action = lsp_zero.cmp_action()
    --         local lspkind = require("lspkind")
    --
    --         cmp.setup({
    --             mapping = cmp.mapping.preset.insert({
    --                 -- `Enter` key to confirm completion
    --                 ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --
    --                 -- Ctrl+Space to trigger completion menu
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --
    --                 ["<Tab>"] = cmp_action.luasnip_supertab(),
    --                 ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    --
    --                 -- Scroll up and down in the completion documentation
    --                 ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    --                 ["<C-d>"] = cmp.mapping.scroll_docs(4),
    --             }),
    --             snippet = {
    --                 expand = function(args)
    --                     require("luasnip").lsp_expand(args.body)
    --                 end,
    --             },
    --             sources = cmp.config.sources({
    --                 { name = "nvim_lsp" },
    --                 { name = "luasnip" },
    --                 { name = "path" },
    --                 { name = "buffer" },
    --             }),
    --             formatting = {
    --                 fields = { "abbr", "kind", "menu" },
    --                 format = lspkind.cmp_format({
    --                     mode = "symbol_text",
    --                     maxwidth = 50,
    --                     ellipsis_char = "...",
    --                     show_labelDetails = true,
    --                 }),
    --             },
    --         })
    --     end,
    -- },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            { "kevinhwang91/nvim-ufo" }
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            require('ufo').setup()
            local lsp_attach = function(client, bufnr)
                if client.name == "angularls" then
                    client.server_capabilities.renameProvider = false
                end
                lsp_zero.highlight_symbol(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end

            local lsp_capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                {
                    textDocument = {
                        foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true
                        }
                    }
                }
            )

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                lsp_capabilities
            )


            lsp_zero.extend_lspconfig({
                capabilities = lsp_capabilities,
                lsp_attach = lsp_attach,
                sign_text = {
                    warn = "▲",
                    hint = "⚑",
                    info = "»",
                    error = "✘",
                },
            })

            require("mason-lspconfig").setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                ensure_installed = { "angularls", "html", "ts_ls", "rust_analyzer", "jdtls", "lua_ls", "marksman" },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                    -- Configured with jdtls.lua
                    jdtls = function() end,
                    -- Configured with rustacean.lua
                    rust_analyzer = function() end,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            on_init = function(client)
                                lsp_zero.nvim_lua_settings(client, {})
                            end,
                        })
                    end,
                    ltex = function()
                        require("lspconfig").ltex.setup({
                            filetypes = {
                                "bib",
                                "gitcommit",
                                "markdown",
                                "org",
                                "plaintex",
                                "rst",
                                "rnoweb",
                                "tex",
                                "pandoc",
                                "quarto",
                                "rmd",
                                "context",
                                "text",
                            },
                        })
                    end,
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<Leader>gq",
                function()
                    require("conform").format({ async = true })
                end,
                desc = "Format Buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                typescript = { "eslint_d" },
                javascript = { "eslint_d" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
}
