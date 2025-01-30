return {
	"mrcjkb/haskell-tools.nvim",
	version = "^4",
	lazy = false,
	keys = {
		{
			"<leader>cl",
			vim.lsp.codelens.run,
		},
	},
}
