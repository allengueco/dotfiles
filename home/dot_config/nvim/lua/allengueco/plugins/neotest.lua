return {
	"nvim-neotest/neotest",
    ft = "java",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rcasia/neotest-java",
	},
	opts = {
		adapters = {
			["neotest-java"] = {},
		},
	},
}
