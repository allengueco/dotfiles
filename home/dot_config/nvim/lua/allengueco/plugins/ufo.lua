return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async'
    },
    init = function()
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function()
        local lsp_zero = require('lsp-zero')

        local lsp_capabilities = vim.tbl_deep_extend(
            'force',
            require('cmp_nvim_lsp').default_capabilities(),
            {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }
                }
            }
        )

        lsp_zero.extend_lspconfig({
            capabilities = lsp_capabilities,
        })
    end,
}
