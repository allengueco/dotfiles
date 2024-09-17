return {
    'akinsho/bufferline.nvim',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        options = {
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
        },
    },
    keys = {
        { "<Alt>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
        { "<Alt>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
        { "<Alt>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
        { "<Alt>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
        { "<Alt>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
        { "<Alt>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
        { "<Alt>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
        { "<Alt>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
        { "<Alt>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
    }
}
