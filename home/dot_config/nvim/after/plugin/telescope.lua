local telescope = require('telescope')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("rg > ") });
end)
telescope.setup {
    pickers = {
        dotfiles = {}
    }
}
vim.keymap.set('n', '<leader>cz', telescope.extensions.chezmoi.find_files, {})
