return {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        lang = 'java',
    },
    -- keys = {
    --     {
    --         '<leader>ll', '<Cmd>Leet list<CR>'
    --     },
    --     {
    --         '<leader>lt', '<Cmd>Leet test<CR>'
    --     },
    --     {
    --         '<leader>ld', '<Cmd>Leet desc<CR>'
    --     },
    --     {
    --         '<leader>li', '<Cmd>Leet info<CR>'
    --     }
    -- }
}
