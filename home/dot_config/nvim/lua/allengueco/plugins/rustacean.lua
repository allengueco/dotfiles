return {
	"mrcjkb/rustaceanvim",
	version = "^5",
    ft = { 'rust' },
    opts = {
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<F4>", function ()
                    vim.cmd.RustLsp("codeAction")
                end, { desc = "RustLsp Code Action", buffer = bufnr })

                vim.keymap.set("n", "K", function ()
                    vim.cmd.RustLsp({'hover', 'actions'})
                end, { desc = "RustLsp Code Action", buffer = bufnr })
            end,
            default_settings = {
                ['rust_analyzer'] = {
                    cargo = {
                        allFeatures = true,
                    },
                    checkOnSave = true,
                    procMacro = {
                        enable = true,
                    }
                }
            }
        }
    },
    config = function (_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim  or {}, opts or {})
    end
}
