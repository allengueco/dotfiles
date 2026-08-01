return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false,
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
