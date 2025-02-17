return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		extensions = {
			"fugitive",
			"fzf",
			"lazy",
			"neo-tree",
			"mason",
			"nvim-dap-ui",
			"quickfix",
			"symbols-outline",
			"trouble",
		},
	},
}
