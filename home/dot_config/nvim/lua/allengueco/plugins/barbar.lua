return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        sidebar_filetypes = {
            undotree = true,
        }
    },
    keys = {
        { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Go to Buffer 1' },
        { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Go to Buffer 2' },
        { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Go to Buffer 3' },
        { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Go to Buffer 4' },
        { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Go to Buffer 5' },
        { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Go to Buffer 6' },
        { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Go to Buffer 7' },
        { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Go to Buffer 8' },
        { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Go to Buffer 9' },
        { '<A-c>', '<Cmd>BufferClose<CR>', desc = 'Close current buffer' },
        { '<A-s-c>', '<Cmd>BufferRestore<CR>', desc = 'Restore buffer' },
    }

}
