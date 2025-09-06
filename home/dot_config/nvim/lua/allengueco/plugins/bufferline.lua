return {
	"akinsho/bufferline.nvim",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = function(_, opts)
		if (vim.g.colors_name or ""):find("catppuccin") then
			opts.highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
		end
		opts.options = {
			close_command = function(bufnum)
				Snacks.bufdelete(bufnum)
			end,
			middle_mouse_command = function(bufnum)
				Snacks.bufdelete(bufnum)
			end,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			diagnostics = "nvim_lsp",
		}
		local Offset = require("bufferline.offset")
		if not Offset.edgy then
			local get = Offset.get
			Offset.get = function()
				if package.loaded.edgy then
					local old_offset = get()
					local layout = require("edgy.config").layout
					local ret = { left = "", left_size = 0, right = "", right_size = 0 }
					for _, pos in ipairs({ "left", "right" }) do
						local sb = layout[pos]
						local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
						if sb and #sb.wins > 0 then
							ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
								or pos == "left" and ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
								or pos == "right"
									and ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
							ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"]
								or sb.bounds.width
						end
					end
					ret.total_size = ret.left_size + ret.right_size
					if ret.total_size > 0 then
						return ret
					end
				end
				return get()
			end
			Offset.edgy = true
		end
	end,
	keys = {
		{ "<S-h>", "<Cmd>BufferLineCyclePrev<CR>" },
		{ "<S-l>", "<Cmd>BufferLineCycleNext<CR>" },
		{ "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>" },
		{ "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>" },
		{ "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>" },
		{ "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>" },
		{ "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>" },
		{ "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>" },
		{ "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>" },
		{ "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>" },
		{ "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>" },
		{ "<A-c>", "<Cmd>BufferLinePickClose<CR>" },
	},
}
