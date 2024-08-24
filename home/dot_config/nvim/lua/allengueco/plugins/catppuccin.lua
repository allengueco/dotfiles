return { 
    'catppuccin/nvim', 
    name = 'catppuccin', 
    priority = 1000, 
    config = function() 
        vim.cmd.colorscheme "catppuccin-frappe" 
    end,
    opts = {
        integrations = {
            barbar = true,
            nvim_surround = true,
            lsp_trouble = true,
            mason = true,
        }
    }
}
