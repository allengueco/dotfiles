return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		extensions = {
			"fugitive",
			"fzf",
			"lazy",
            "man",
			"mason",
			"neo-tree",
			"nvim-dap-ui",
			"quickfix",
			"symbols-outline",
			"trouble",
		},
	},
}
