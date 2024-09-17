vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pe", '<cmd>NvimTreeToggle<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<A-c>", "bdelete! %")
