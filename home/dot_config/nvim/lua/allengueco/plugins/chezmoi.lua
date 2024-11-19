return {
    {
        'alker0/chezmoi.vim',
        lazy = false,
        init = function()
            vim.g['chezmoi#use_tmp_buffer'] = true
        end
    },
    {
        'xvzc/chezmoi.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            edit = {
                watch = true,
            },
            notification = {
                on_watch = true,
            }
        },
    }
}
