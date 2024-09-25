return {
	"mrcjkb/rustaceanvim",
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
