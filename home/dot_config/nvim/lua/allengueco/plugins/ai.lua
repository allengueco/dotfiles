return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "anthropic",
			},
		},
	},
}
