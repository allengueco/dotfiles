-- vim.keymap.set('n', '<leader>cz', telescope.extensions.chezmoi.find_files, {})

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	opts = {
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
		},
	},
	keys = {
		{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>" },
		{ "<leader>fg", "<cmd>lua require('telescope.builtin').git_files()<CR>" },
		{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>" },
		{ "<leader>cz", "<cmd>ChezmoiList<CR>" },
	},
}
