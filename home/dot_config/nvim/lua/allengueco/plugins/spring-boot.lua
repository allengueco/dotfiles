return {
	{
		"JavaHello/spring-boot.nvim",
		ft = { "java", "yaml", "jproperties" },
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"ibhagwan/fzf-lua",
		},
		---@type bootls.Config
		opts = {},
	},
}
