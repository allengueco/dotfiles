return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				signature = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
			},
			presets = {
				long_message_to_split = true,
				inc_rename = false,
                lsp_doc_border = false,
			},
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
                        cond = function (message)
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            return client == "jdtls"
                        end
					},
					opts = { skip = true },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "wrapped-compact",
		},
	},
}
