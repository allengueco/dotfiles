return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
        require('catppuccin').setup(
            {
                integrations = {
                    barbar = true,
                    nvim_surround = true,
                    blink_cmp = true,
                    lsp_trouble = true,
                    diffview = true,
                    mason = true,
                    indent_blankline = {
                        colored_indent_levels = true,
                    },
                    neotest = true,
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                    which_key = true,
                },
                styles = {
                    functions = { "italic" },
                    types = { "italic" }
                }
            }
        )
        vim.cmd.colorscheme "catppuccin-frappe"
    end,
}
