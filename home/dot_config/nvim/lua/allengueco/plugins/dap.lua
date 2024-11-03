return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<F5>", "<Cmd>lua require('dap').continue()" },
		{ "<F7>", "<Cmd>lua require('dap').step_into()" },
		{ "<F8>", "<Cmd>lua require('dap').step_over()" },
		{ "<F9>", "<Cmd>lua require('dap').step_out()" },
		{
			"<Leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<Leader>B",
			function()
				require("dap").set_breakpoint()
			end,
		},
		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
		},
		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").preview()
			end,
		},
		{
			"<Leader>df",
			function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end,
		},
		{
			"<Leader>ds",
			function()
                local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end,
		},
	},
}
