vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local map = function(m, lhs, rhs, desc)
			local key_opts = { buffer = event.buf, desc = desc, silent = true, nowait = true }
			vim.keymap.set(m, lhs, rhs, key_opts)
		end
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover documentation")
		map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
		map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
		map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
		map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
		map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference")
		map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show function signature")
		map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
		map("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format file")
		map("x", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format selection")
		map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action")
	end,
})
