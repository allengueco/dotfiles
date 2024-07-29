require('obsidian').setup {
    workspaces = {
        {
            name = 'personal',
            path = '~/vaults/personal'
        }
    },

    follow_url_func = function(url)
        vim.fn.jobstart({"open", url})
    end
}
