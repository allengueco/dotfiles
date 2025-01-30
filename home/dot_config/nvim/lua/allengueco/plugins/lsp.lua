return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
				},
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lazydev = { fallbacks = { "lsp" }, name = "LazyDev", module = "lazydev.integrations.blink" },
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
			completion = {
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				documentation = {
					auto_show = true,
				},
				accept = {
					auto_brackets = {
						enabled = true,
					},
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
			{ "saghen/blink.cmp" },
			{ "folke/neoconf.nvim" },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local map = function(m, lhs, rhs, desc)
						local key_opts = { buffer = event.buf, desc = desc, silent = true, nowait = true }
						vim.keymap.set(m, lhs, rhs, key_opts)
					end
					map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
					map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
					map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
					map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
					map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
					map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference")
					map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature")
					map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
					map("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format file")
					map("x", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format selection")
					map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action")
				end,
			})
			-- local lsp_capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
			-- 	textDocument = {
			-- 		foldingRange = {
			-- 			dynamicRegistration = false,
			-- 			lineFoldingOnly = true,
			-- 		},
			-- 	},
			-- })
			--
			-- local lspconfig_defaults = require("lspconfig").util.default_config
			-- lspconfig_defaults.capabilities =
			-- 	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, lsp_capabilities)

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
                    hls = function() end,
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
