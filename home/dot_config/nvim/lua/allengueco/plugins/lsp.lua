return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			cmdline = {
				keymap = { preset = "enter" },
				completion = {
					list = {
						selection = {
							preselect = false,
						},
					},
				},
			},
			keymap = {
				preset = "enter",
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
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
				ghost_text = { enabled = true },
				menu = {
					auto_show = false,
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
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
		"mason-org/mason-lspconfig.nvim",
		opts = {
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                    "hls",
                    "ltex",
                }
            },
		},
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason-lspconfig.nvim" },
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
				{
					path = "${3rd}/luv/library",
					words = { "vim%.uv" },
				},
				{
					path = "snacks.nvim",
					words = { "Snacks" },
				},
			},
		},
	},
	{
		"xzbdmw/colorful-menu.nvim",
	},
}
