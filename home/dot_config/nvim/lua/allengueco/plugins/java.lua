return {
	"nvim-java/nvim-java",
	config = function()
		require("lspconfig").jdtls.setup({
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
		require("java").setup({
			jdk = {
				auto_install = false,
			},
			notifications = {
				dap = false,
			},
		})
	end,
}
