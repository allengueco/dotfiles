return {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<leader>pe', '<Cmd>NvimTreeToggle<CR>', desc = 'Open Nvim-Tree' }
    },
    opts = {
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        renderer = {
            group_empty = true,
        }
    }
}
