return {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    opts = {
        workspaces = {
            {
                name = "aws",
                path = "~/vaults/aws"
            },
            {
                name = "personal",
                path = "~/vaults/personal"
            },
            {
                name = "leetcode",
                path = "~/leetcode"
            }
        }
    }
}
