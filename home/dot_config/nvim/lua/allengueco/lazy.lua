local uv = vim.uv or vim.loop
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- stylua: ignore
	spec = {
		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "saecki/crates.nvim", event = "BufRead Cargo.toml", tag = "stable" },
		{ "nvim-neotest/nvim-nio" },
		{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		{ "folke/neoconf.nvim" },
		{ "folke/ts-comments.nvim", event = "VeryLazy" },
		{ import = "allengueco.plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
