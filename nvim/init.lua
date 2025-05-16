-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.cmd.set "number"
vim.cmd.set "tabstop=8"
vim.cmd.set "softtabstop=0"
vim.cmd.set "expandtab"
vim.cmd.set "shiftwidth=4"
vim.cmd.set "smarttab"
vim.keymap.set("n", "<A-left>", function() vim.cmd.wincmd "<" end)
vim.keymap.set("n", "<A-right>", function() vim.cmd.wincmd ">" end)
vim.keymap.set("n", "<A-up>", function() vim.cmd.wincmd "-" end)
vim.keymap.set("n", "<A-down>", function() vim.cmd.wincmd "+" end)
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeOpen)

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('W', 'w', {})

vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

require("run") -- our magical run script

local plugins = {
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
            "sharkdp/fd",
            "nvim-treesitter/nvim-treesitter",
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
            "mrcjkb/rustaceanvim",
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    "hrsh7th/cmp-nvim-lsp",
                },
            },
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        config = function()
            local ls = require("luasnip")

            vim.keymap.set({ "i" }, "<C-space>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-P>", function() ls.jump(-1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })

            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                theme = 'catppuccin',
                options = {
                    component_separators = '',
                    section_separators = '',
                }
            }
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
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "folke/trouble.nvim",
        },
        lazy = false,
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                test = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
                cascade = {
                    mode = "diagnostics", -- inherit from diagnostics mode
                    filter = function(items)
                        local severity = vim.diagnostic.severity.HINT
                        for _, item in ipairs(items) do
                            severity = math.min(severity, item.severity)
                        end
                        return vim.tbl_filter(function(item)
                            return item.severity == severity
                        end, items)
                    end,
                },
            },
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "ziglang/zig.vim",
    },
    {
        "mfussenegger/nvim-jdtls"
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_clean_paths = { '_minted*' }
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', '-shell-escape'
                }
            }
            vim.g.vimtex_compiler_latexmk_engines = { ["_"] = '-lualatex' }
        end
    }
}

require("lazy").setup(plugins, {})
