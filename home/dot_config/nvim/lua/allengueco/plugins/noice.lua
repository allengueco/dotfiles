return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            cmdline = {
                enabled = true,
            },
            lsp = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            presets = {
                long_message_to_split = true,
                command_palette = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            routes = {
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                        cond = function(message)
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            return client == "jdtls"
                        end,
                    },
                    opts = { skip = true },
                },
            },
        },
    },
    {
        "rcarriga/nvim-notify",
        enabled = false,
        opts = {
            render = "wrapped-compact",
        },
    },
}
