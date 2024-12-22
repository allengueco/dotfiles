return {
	"folke/edgy.nvim",
	opts = {
        animate = { enabled = false },
		left = {
			{
				title = "Nvim-Tree",
				ft = "NvimTree",
				size = { height = 0.5 },
			},
		},
		bottom = {
			{
				ft = "snacks_terminal",
				size = { height = 0.4 },
				title = "%{b:snacks_terminal.id}: %{b:term_title}",
				filter = function(_buf, win)
					return vim.w[win].snacks_win
						and vim.w[win].snacks_win.position == pos
						and vim.w[win].snacks_win.relative == "editor"
						and not vim.w[win].trouble_preview
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
		},
		right = {
			{
				title = function()
					local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
					return vim.fn.fnamemodify(buf_name, ":t")
				end,
				ft = "Outline",
				pinned = true,
				open = "SymbolsOutlineOpen",
			},
		},
	},
}
