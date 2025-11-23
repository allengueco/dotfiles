return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {
            registries = {
                "github:nvim-java/mason-registry",
                "github:mason-org/mason-registry",
            }
        },
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
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"angularls",
				"cssls",
				"css_variables",
				"html",
				"jsonls",
				"ltex",
				"lua_ls",
				"marksman",
				"rust_analyzer",
				"stylua",
				"tailwindcss",
				"tinymist",
				"ts_ls",
			},
			automatic_enable = {
				exclude = {
					"rust_analyzer",
					"ltex",
				},
			},
		},
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
