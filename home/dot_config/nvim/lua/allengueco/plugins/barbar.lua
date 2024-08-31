return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        options = {
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' },
            },
            offsets = {
                {
                    filetype = 'NvimTree',
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                }
            }
        }
    }
}
