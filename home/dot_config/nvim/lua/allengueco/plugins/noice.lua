return {

    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            }
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
}
