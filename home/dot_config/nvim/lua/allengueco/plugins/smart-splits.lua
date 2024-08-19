return {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    keys = {
        { '<A-h>', require('smart-splits').resize_left },
        { '<A-j>', require('smart-splits').resize_down },
        { '<A-k>', require('smart-splits').resize_up },
        { '<A-l>', require('smart-splits').resize_right },

        { '<C-h>', require('smart-splits').move_cursor_left },
        { '<C-j>', require('smart-splits').move_cursor_down },
        { '<C-k>', require('smart-splits').move_cursor_up },
        { '<C-l>', require('smart-splits').move_cursor_right },
     
        { '<leader><leader>h', require('smart-splits').swap_buf_left },
        { '<leader><leader>j', require('smart-splits').swap_buf_down },
        { '<leader><leader>k', require('smart-splits').swap_buf_up },
        { '<leader><leader>l', require('smart-splits').swap_buf_right },
    }
}
