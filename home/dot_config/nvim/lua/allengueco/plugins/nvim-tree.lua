return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
    enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>pe", "<Cmd>NvimTreeToggle<CR>", desc = "Open Nvim-Tree" },
	},
	opts = {
		disable_netrw = true,
		hijack_cursor = true,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		respect_buf_cwd = true,
		sync_root_with_cwd = true,
		renderer = {
			group_empty = true,
		},
	},
	init = function()
		local prev = { new_name = "", old_name = "" }
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})
	end,
}
