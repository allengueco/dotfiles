return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
	opts = {},
	keys = {
		{ "<leader>ff", "<Cmd>FzfLua files<CR>", desc = "Fzf Files" },
	},
}
