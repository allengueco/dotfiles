return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {},
	keys = {
		{
			"<leader>m",
			"<Cmd>TSJToggle<CR>",
			desc = "Toggle Node under curser (TSJ)",
		},
		{
			"<leader>s",
			"<Cmd>TSJSplit<CR>",
			desc = "Split Node under curser (TSJ)",
		},
		{
			"<leader>j",
			"<Cmd>TSJJoin<CR>",
			desc = "Join Node under curser (TSJ)",
		},
	},
}
