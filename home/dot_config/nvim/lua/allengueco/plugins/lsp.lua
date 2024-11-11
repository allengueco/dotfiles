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
				completion = {
					enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
				},
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lsp = { fallback_for = { "lazydev" } },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
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
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<Tab>"] = {
					function(cmp)
						if cmp.is_in_snippet() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
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
			{ "saghen/blink.cmp" },
			{ "folke/neoconf.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			require("ufo").setup()
            require("neoconf").setup()
			local lsp_attach = function(client, bufnr)
				if client.name == "angularls" then
					client.server_capabilities.renameProvider = false
				end
				lsp_zero.default_keymaps({ buffer = bufnr })
				lsp_zero.highlight_symbol(client, bufnr)
			end

			local lsp_capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
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
					-- Configured with rustacean.lua
					rust_analyzer = function() end,
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
	-- Formatting
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
				typescript = { "prettierd" },
				javascript = { "prettierd" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	-- Linting
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
			}
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
