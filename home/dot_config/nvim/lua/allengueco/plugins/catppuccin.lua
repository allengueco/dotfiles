return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				nvim_surround = true,
				blink_cmp = true,
				lsp_trouble = true,
				gitsigns = true,
				diffview = true,
                grug_far = true,
				mason = true,
				noice = true,
				notify = true,
				snacks = true,
				neotest = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				which_key = true,
			},
			styles = {
				functions = { "italic" },
				types = { "italic" },
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
