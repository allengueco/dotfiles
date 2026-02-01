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
        adapters = {
            http = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = {
                            api_key = ""
                        }
                    })
            }
        }
	},
}
