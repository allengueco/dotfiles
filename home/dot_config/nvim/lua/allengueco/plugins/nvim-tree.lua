return {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    config = function()
        local function open_nvim_tree(data)
            local real_file = vim.fn.filereadable(data.file) == 1

            local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

            if not real_file and not no_name then
                return
            end

            require('nvim-tree.api').tree.toggle({ focuse = false })

            vim.api.nvim_exec_autocmds('BufWinEnter', { buffer = require('nvim-tree.view').get_bufnr() })
        end

        vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
    end,
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
