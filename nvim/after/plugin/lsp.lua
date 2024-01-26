local lsp_config = require 'lspconfig'
local rust_tools = require 'rust-tools'

local lsp = require("lsp-zero").preset {
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
}

lsp.ensure_installed {
    --    'rust_analyzer',
    --    'pyright',
    'lua_ls',
    --    'clangd',
    --    'tsserver',
    --    'zls',
}

local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Return>'] = cmp.mapping.confirm({ select = true }),
    ["<S-Tab>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp {
    mapping = cmp_mappings
}

-- lua neovim config fixes
lsp_config.lua_ls.setup(lsp.nvim_lua_ls())

local lsp_on_attatch = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.on_attach(lsp_on_attatch)

-- format on save
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['pyright'] = { 'python' },
        ['black'] = { 'python' },
        ['clangd'] = { 'c', 'cpp' },
        ['zls'] = { 'zig' },
        ['tsserver'] = { 'js', 'jsx', 'ts', 'tsx' },
    }
})

lsp_config.clangd.setup({ server = { on_attatch = lsp_on_attatch } })

-- rust..?
lsp.skip_server_setup({ 'rust-analyzer' })

lsp.setup()

rust_tools.setup({
    server = {
        on_attatch = lsp_on_attatch
    }
})
