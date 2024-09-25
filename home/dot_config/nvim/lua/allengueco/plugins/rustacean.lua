return {
	"mrcjkb/rustacean.nvim",
	version = "^5",
	lazy = false,
    config = function ()
        vim.g.rustaceanvim = {
            server = {
                capabilities = require('lsp-zero').get_capabilities()
            }
        }
    end
}
