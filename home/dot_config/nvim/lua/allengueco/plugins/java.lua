return {
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	},
	-- Using autocmd launch (default)
	-- Default uses jars from mason or ~/.vscode/extensions/vmware.vscode-spring-boot-x.x.x
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
