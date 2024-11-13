return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			preset = "obsidian",
			overrides = {
				link = {
					custom = {
						jdt = {
							pattern = "^jdt://",
							icon = "󰖟 ",
							highlight = "RenderMarkdownLink",
						},
					},
				},
				anti_conceal = {
					ignore = {
						link = true,
					},
				},
			},
		},
	},
}
