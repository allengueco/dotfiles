return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
    enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = function(_, opts)
		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end
		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
		-- For flattening java projects
		opts.group_empty_dirs = true
		opts.buffers = {
			show_unloaded = true,
		}
		opts.open_files_do_not_replace = {
			"terminal",
			"snacks_terminal",
			"Trouble",
			"trouble",
			"qf",
			"edgy",
			"Outline",
		}
		opts.filesystem = {
			bind_to_cwd = false,
			scan_mode = "deep",
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		}
	end,
}
