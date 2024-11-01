return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	ft = "rust",
	init = function()
		vim.g.rustaceanvim = {
			server = {
				capabilities = require("lsp-zero").get_capabilities(),
				on_attach = function(client, bufnr)
					vim.keymap.set("n", "<F4>", function()
						vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
						-- or vim.lsp.buf.codeAction() if you don't want grouping.
					end, { silent = true, buffer = bufnr })

					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "action" })
					end, { silent = true, buffer = bufnr })
				end,
			},
		}
	end,
}
