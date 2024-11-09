return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {
		current_line_blame = true,
		numhl = true,
		linehl = true,
		word_diff = true,
		current_line_blame_opts = {
			virt_text_pos = "right_align",
			delay = 500,
		},
		preview_config = {
			border = "none",
		},
	},
	keys = {
		{
			"<Leader>hp",
			"<Cmd>Gitsigns preview_hunk<CR>",
			desc = "Preview hunk",
		},
	},
}
