return {
	"nvim-java/nvim-java",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	opts = {
		jdk = {
			auto_install = false,
		},
		notifications = {
			dap = false,
		},
	},
}
