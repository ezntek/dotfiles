local lsp_config = require 'lspconfig'
local cmp = require 'cmp'
local lsp = require("lsp-zero").preset {
    suggest_lsp_servers = false,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Return>'] = cmp.mapping.confirm({ select = true }),
    ["<S-Tab>"] = cmp.mapping.complete(),
    ["<Tab"] = cmp.mapping.complete(),
})

cmp.setup {
    sources = {
        { name = "nvim_lsp" },
    },
    mapping = cmp_mappings,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
}

-- lua neovim config fixes
lsp_config.lua_ls.setup(lsp.nvim_lua_ls())

local function lsp_on_attach(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.diagnostic.config({ virtual_text = true })

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.on_attach(lsp_on_attach)

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

vim.diagnostic.config({
    signs = true
})

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
        ['ts_ls'] = { 'js', 'jsx', 'ts', 'tsx' },
        ['jdtls'] = { 'java' },
        ['texlab'] = { 'tex' },
        ['harper_ls'] = { 'tex', 'markdown' },
    }
})


local cfg = { server = { on_attach = lsp_on_attach }, capabilities = capabilities }

vim.lsp.config("harper_ls", {
    settings = {
        ["harper-ls"] = {
            userDictPath = "",
            dialect = "American",
            diagnosticSeverity = "info",
        },
        --filetypes = { "tex", "markdown" },
    },
    filetypes = { "tex", "markdown" },
})

lsp_config.pyright.setup(cfg)
lsp_config.clangd.setup(cfg)
lsp_config.ts_ls.setup(cfg)
lsp_config.ols.setup(cfg)
lsp_config.zls.setup(cfg)
lsp_config.texlab.setup(cfg)
--cfg.filetypes = { "tex", "markdown" }
lsp_config.harper_ls.setup(cfg)

vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = lsp_on_attach,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}
