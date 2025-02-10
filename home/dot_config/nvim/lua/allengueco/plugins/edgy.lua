return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = function()
		local opts = {
			animate = { enabled = false },
			left = {
				{
					title = "Neotest Summary",
					ft = "neotest-summary",
				},
			},
			bottom = {
				{
					ft = "noice",
					size = { height = 0.4 },
					filter = function(_, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				"Trouble",
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{
					title = "Neotest Output",
					ft = "neotest-output-panel",
					size = { height = 15 },
				},
			},
			right = {
				{
					title = "Grug Far",
					ft = "grug-far",
					size = { width = 0.4 },
				},
			},
			keys = {
				-- increase width
				["<c-Right>"] = function(win)
					win:resize("width", 2)
				end,
				-- decrease width
				["<c-Left>"] = function(win)
					win:resize("width", -2)
				end,
				-- increase height
				["<c-Up>"] = function(win)
					win:resize("height", 2)
				end,
				-- decrease height
				["<c-Down>"] = function(win)
					win:resize("height", -2)
				end,
			},
		}
		-- trouble
		for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
			opts[pos] = opts[pos] or {}
			table.insert(opts[pos], {
				ft = "trouble",
				filter = function(_buf, win)
					return vim.w[win].trouble
						and vim.w[win].trouble.position == pos
						and vim.w[win].trouble.type == "split"
						and vim.w[win].trouble.relative == "editor"
						and not vim.w[win].trouble_preview
				end,
			})
		end

        -- snacks terminal
		for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
			opts[pos] = opts[pos] or {}
			table.insert(opts[pos], {
				ft = "snacks_terminal",
				size = { height = 0.4 },
				title = "%{b:snacks_terminal.id}: %{b:term_title}",
				filter = function(_, win)
					return vim.w[win].snacks_win
						and vim.w[win].snacks_win.position == pos
						and vim.w[win].snacks_win.relative == "editor"
						and not vim.w[win].trouble_preview
				end,
			})
		end

		return opts
	end,
	keys = {
		{
			"<leader>ue",
			function()
				require("edgy").toggle()
			end,
			desc = "Edgy Toggle",
		},
		{
			"<leader>uE",
			function()
				require("edgy").select()
			end,
			desc = "Edgy Select Window",
		},
	},
}
