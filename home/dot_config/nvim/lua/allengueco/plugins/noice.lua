return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	opts = {
        cmdline = {
            
        },
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
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
		},
	},
}
