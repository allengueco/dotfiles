return {
    'kevinhwang91/nvim-ufo',
    enabled = false,
    dependencies = {
        'kevinhwang91/promise-async'
    },
    init = function()
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.api.nvim_create_autocmd('Filetype', {
            pattern = {
                'NeogitStatus',
            },
            callback = function()
                require('ufo').detach()
                vim.opt_local.foldenable = false
                vim.opt_local.foldcolumn = '0'
            end
        })
    end,
}
