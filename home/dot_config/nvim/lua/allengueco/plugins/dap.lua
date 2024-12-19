return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<F5>", "<Cmd>lua require('dap').continue()<CR>", desc = "Continue" },
		{ "<F7>", "<Cmd>lua require('dap').step_into()<CR>", desc = "Step into" },
		{ "<F8>", "<Cmd>lua require('dap').step_over()<CR>", desc = "Step over" },
		{ "<F9>", "<Cmd>lua require('dap').step_out()<CR>", desc = "Step out" },
		{
			"<Leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
            desc = "(DAP) Toggle breakpoint"
		},
		{
			"<Leader>B",
			function()
				require("dap").set_breakpoint()
			end,
            desc = "(DAP) Set breakpoint"
		},
		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
            desc = "(DAP) Hover"
		},
		{
			"<Leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
            desc = "(DAP) Preview"
		},
		{
			"<Leader>dF",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
            desc = "(DAP) Float"
		},
		{
			"<Leader>dS",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
            desc = "(DAP) Scope"
		},
	},
}
