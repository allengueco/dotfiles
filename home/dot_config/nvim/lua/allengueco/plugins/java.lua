return {
	"nvim-java/nvim-java",
	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
		})
		require("lspconfig").jdtls.setup({
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
	end,
}
