return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
    config = function ()
        vim.g.rustaceanvim = {
            server = {
                capabilities = require('blink.cmp').get_lsp_capabilities()
            }
        }
    end
}
