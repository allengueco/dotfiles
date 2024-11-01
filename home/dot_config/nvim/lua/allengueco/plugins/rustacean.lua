return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	init = function()
        local bufnr = vim.api.nvim_get_current_buf()
		vim.keymap.set("n", "K", function()
			vim.cmd.RustLsp({ "hover", "action" })
		end,
        { silent = true, buffer = bufnr }
        )
	end,
}
