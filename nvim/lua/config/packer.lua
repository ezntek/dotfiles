-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local function plugins(use)
    -- catppuccin yay
    use { "catppuccin/nvim", as = "catppuccin" }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        }
    }

    -- treesitter
    use(
        "nvim-treesitter/nvim-treesitter",
        {
            run = ':TSUpdate'
        }
    )

    -- harpoon (by the primeagen)
    use "theprimeagen/harpoon"

    -- undotree
    use "mbbill/undotree"

    -- fugitive
    use "tpope/vim-fugitive"

    -- nvim-tree
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            { 'nvim-tree/nvim-web-devicons' },
        }
    }

    -- yay lsp

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = vim.cmd.MasonUpdate
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            -- inlay hints
            { "simrat39/rust-tools.nvim" },
        }
    }

    -- airline
    use {
        "vim-airline/vim-airline",
        requires = {
            "vim-airline/vim-airline-themes"
        }
    }

    -- tabs
    use {
        'romgrk/barbar.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
            'lewis6991/gitsigns.nvim'      -- OPTIONAL: for git status
        }
    }

    -- crates.nvim
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }

    -- todo comments
    use {
        "folke/todo-comments.nvim",
        requires = { "folke/trouble.nvim" }
    }

    -- packer itself
    use 'wbthomason/packer.nvim'

    -- ron
    use 'ron-rs/ron.vim'
end

return require('packer').startup(plugins)
