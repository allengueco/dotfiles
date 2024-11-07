return {
    'akinsho/bufferline.nvim',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'famiu/bufdelete.nvim',
    },
    opts = function(_, opts)
        if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlight = require('catppuccin.groups.integrations.bufferline').get()
        end
        opts.options = {
            close_command = function(bufnum)
                require('bufdelete').bufdelete(bufnum, true)
            end,
            middle_mouse_command = function(bufnum)
                require('bufdelete').bufdelete(bufnum, true)
            end,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                }
            }
        }
    end,
    keys = {
        { "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>" },
        { "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>" },
        { "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>" },
        { "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>" },
        { "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>" },
        { "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>" },
        { "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>" },
        { "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>" },
        { "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>" },
        { "<A-c>", "<Cmd>BufferLinePickClose<CR>" }
    }
}
