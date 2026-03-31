return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
        flavour = "mocha",
		auto_integrations = true,
		lsp_styles = {
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		styles = {
			functions = { "italic" },
			types = { "italic" },
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
