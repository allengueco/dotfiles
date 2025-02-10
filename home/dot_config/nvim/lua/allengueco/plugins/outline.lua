return {
	"hedyhli/outline.nvim",
    enabled = false,
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>cs", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = {
		-- Your setup opts here
	},
}
