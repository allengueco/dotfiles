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
    keys = {
        {
            '<Leader>ll', '<Cmd>Leet list<CR>'
        },
        {
            '<Leader>lt', '<Cmd>Leet test<CR>'
        },
        {
            '<Leader>ld', '<Cmd>Leet desc<CR>'
        },
        {
            '<Leader>li', '<Cmd>Leet info<CR>'
        }
    }
}
