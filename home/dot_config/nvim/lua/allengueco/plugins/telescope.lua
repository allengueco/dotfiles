-- vim.keymap.set('n', '<leader>cz', telescope.extensions.chezmoi.find_files, {})

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = false,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' }
    },
    keys = {
        { '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>" }
    },
    config = function ()
       require('telescope').load_extension('ui-select')
    end
}
