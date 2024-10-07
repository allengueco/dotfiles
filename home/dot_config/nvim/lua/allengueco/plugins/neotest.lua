return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		adapters = {
			["neotest-java"] = {},
		},
	},

    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfusseneger/nvim-jdtls",
            "mfusseneger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text"
        }
    }
}
