return {
	"nvim-java/nvim-java",
	config = function()
		require("lspconfig").jdtls.setup({
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
	end,
}
