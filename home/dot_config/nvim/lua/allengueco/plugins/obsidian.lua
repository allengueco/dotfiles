return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		picker = {
			name = "snacks.picker",
		},
		workspaces = {
			{ name = "personal", path = "~/vaults/personal" },
			{ name = "work", path = "~/vaults/work" },
		},
	},
}
