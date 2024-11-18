return {
	"nvim-java/nvim-java",
	ft = "java",
	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
			notifications = {
				dap = false,
			},
		})
		require("lspconfig").jdtls.setup({
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
	end,
}
