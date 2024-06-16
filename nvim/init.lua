local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd.set "number"
vim.cmd.set "tabstop=8"
vim.cmd.set "softtabstop=0"
vim.cmd.set "expandtab"
vim.cmd.set "shiftwidth=4"
vim.cmd.set "smarttab"
vim.g.mapleader = " "
vim.keymap.set("n", "<A-left>", function() vim.cmd.wincmd "<" end)
vim.keymap.set("n", "<A-right>", function() vim.cmd.wincmd ">" end)
vim.keymap.set("n", "<A-up>", function() vim.cmd.wincmd "-" end)
vim.keymap.set("n", "<A-down>", function() vim.cmd.wincmd "+" end)
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeOpen)

plugins = {
	{ 
		"catppuccin/nvim",
		lazy = false,
		config = function()
			vim.cmd [[colorscheme catppuccin-macchiato]]
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		
		"nvim-treesitter/nvim-treesitter",
		config = function()
			vim.cmd [[TSUpdate]]
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>g", vim.cmd.Git)
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"simrat39/rust-tools.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
                        "L3MON4D3/LuaSnip",
		},
	},
	{
		"vim-airline/vim-airline",
		dependencies = {
			"vim-airline/vim-airline-themes",
		},
		config = function()
			vim.g["airline_theme"] = "catppuccin"
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
		},
	},
	{
		"saecki/crates.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require("crates").setup()
		end
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"folke/trouble.nvim",
		},
		config = function()
			require("todo-comments").setup()
		end,
	},
}

require("lazy").setup(plugins, optso)
