return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {},
	keys = {
		{ "<leader>m", "<Cmd>TSJToggle<CR>" },
		{ "<leader>s", "<Cmd>TSJSplit<CR>" },
		{ "<leader>j", "<Cmd>TSJJoin<CR>" },
	},
}
