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
		"saghen/blink.cmp",
		lazy = false,
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		opts = {
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			sources = {
				providers = {
					snippets = {
						opts = {
							extended_filetypes = {
								typescript = { "angular" },
								html = { "angular" },
								htmlangular = { "angular" },
							},
						},
					},
				},
			},
			windows = {
				autocomplete = {
					selection = "manual",
					draw = "reversed",
				},
				documentation = {
					auto_show = true,
				},
			},
			nerd_font_variant = "mono",
			keymap = {
				show = "<C-Space>",
				hide = "<C-e>",
				accept = "<CR>",
				show_documentation = "<C-Space>",
				hide_documentation = "<C-Space>",
				scroll_documentation_up = "<C-u>",
				scroll_documentation_down = "<C-d>",
				snippet_forward = "<Tab>",
				snippet_backward = "<S-Tab>",
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "kevinhwang91/nvim-ufo" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			require("ufo").setup()
			local lsp_attach = function(client, bufnr)
				if client.name == "angularls" then
					client.server_capabilities.renameProvider = false
				end
				lsp_zero.highlight_symbol(client, bufnr)
			end

			local lsp_capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			})

			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities =
				vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, lsp_capabilities)

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
				ensure_installed = {
					"angularls",
					"html",
					"ts_ls",
					"rust_analyzer",
					"jdtls",
					"lua_ls",
					"marksman",
				},
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
