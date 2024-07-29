-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- ensures packer is installed in the machine.
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "catppuccin/nvim", as = "catppuccin" }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use { 'hrsh7th/nvim-cmp' }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use('mfussenegger/nvim-jdtls')
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use('tpope/vim-surround')
    use('romgrk/barbar.nvim')
    use('nvim-tree/nvim-web-devicons')
    use('nvim-lualine/lualine.nvim')
    use {
        'nvimdev/dashboard-nvim',
        -- See: https://github.com/nvimdev/dashboard-nvim/issues/359#issuecomment-1646270988
        -- event = 'VimEnter',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use('folke/trouble.nvim')
    use('mfussenegger/nvim-dap')
    use('nvim-neotest/nvim-nio')
    use {
        'rcarriga/nvim-dap-ui',
        requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    }
    use {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {
                map_cr = false
            }
        end
    }

    use {
        'saecki/crates.nvim',
        event = "BufRead Cargo.toml",
        tag = 'stable',
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    use {
        'alker0/chezmoi.vim',
        init = function()
            -- this option is required to prevent having to care about plugin
            -- order
            vim.g['chezmoi#use_tmp_buffer'] = true
        end
    }

    use {
        'epwalsh/obsidian.nvim',
        tag = '*',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'xvzc/chezmoi.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    }
    use {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('conform').setup {}
        end,
    }
end)
