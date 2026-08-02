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
		notes_subdir = "0-fleeting",
		new_notes_location = "notes_subdir",
		note_id_func = function(title, dir)
			return require("obsidian.builtin").title_id(title, dir)
		end,
		templates = {
			substitutions = {},
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%HH:%M",
		},
	},
	keys = {
		{ "<Leader>on", "<cmd>Obsidian new_from_template", desc = "(Obsidian) New from template" },
	},
}
