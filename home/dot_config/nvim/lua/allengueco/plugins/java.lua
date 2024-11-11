return {
	"nvim-java/nvim-java",
    opts = {
        jdk = {
            auto_install = false,
        }
    },
	config = function()
		require("lspconfig").jdtls.setup({
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
	end,
}
