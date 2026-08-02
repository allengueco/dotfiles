return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	---@module 'obsidian'
	---@type function|obsidian.config
	opts = function()
		return {
			legacy_commands = false,
			picker = {
				name = "snacks.picker",
			},
			workspaces = {
				{ name = "personal", path = "~/vaults/personal" },
				{ name = "work", path = "~/vaults/work" },
			},
			note_id_func = function(title)
				return require("obsidian.builtin").title_id(title)
			end,
			templates = {
				substitutions = {},
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%HH:%M",
			},
		}
	end,
}
