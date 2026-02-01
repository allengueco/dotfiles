return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
    enabled = false,
	opts = {
		interactions = {
			chat = {
				adapter = "anthropic",
			},
		},
	},
}
