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
        note_id_func = require("obsidian.builtin").title_id,
        notes_subdir = "notes",
        new_notes_location = "notes_subdir",
        daily_notes = {
            folder = "daily",
            date_format = "%Y-%m-%d",
        },
        templates = {
            substitutions = {},
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%HH:%M"
        }
	},
}
