return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async'
    },
    event = "BufRead",
    init = function()
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    keys = {
        {
            'zR', "<Cmd>lua require('ufo').openAllFolds()<CR>"
        },
        {
            'zM', "<Cmd>lua require('ufo').closeAllFolds()<CR>"
        }
    }
}
