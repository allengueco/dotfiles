local leet_arg = "leetcode.nvim"

return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = leet_arg ~= vim.fn.argv()[1],
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "java",
		arg = leet_arg,
	},
	keys = {
		{
			"<leader>ll",
			"<Cmd>Leet list<CR>",
		},
		{
			"<leader>lt",
			"<Cmd>Leet test<CR>",
		},
		{
			"<leader>ld",
			"<Cmd>Leet desc<CR>",
		},
		{
			"<leader>li",
			"<Cmd>Leet info<CR>",
		},
		{
			"<leader>lc",
			"<Cmd>Leet console<CR>",
		},
	},
}
