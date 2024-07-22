local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)


lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})
lsp_zero.setup()
-- Mason Configure
require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {'angularls', 'html', 'tsserver', 'rust_analyzer', 'jdtls'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        jdtls = lsp_zero.noop,
    }
})

