return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	ft = "rust",
	config = function()
		vim.g.rustaceanvim = {
			server = {
				capabilities = require("lsp-zero").get_capabilities(),
			},
		}
	end,
	keys = {
		{
			"K",
			function()
				vim.cmd.RustLsp({ "hover", "action" })
			end,
			silent = true,
		},
		{
			"<F4>",
			function()
				vim.cmd.RustLsp("codeAction")
			end,
			silent = true,
		},
	},
}
