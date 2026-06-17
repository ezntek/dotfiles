function CEDev(lsp_on_attach, capabilities)
    local ticfg = {
        cmd = { "/home/ezntek/Sources/ti/llvm-project/build/bin/clangd" },
        server = { on_attach = lsp_on_attach },
        capabilities = capabilities
    }
    vim.lsp.config("clangd", ticfg)
end

function Normal(lsp_on_attach, capabilities)
    local cfg = {
        cmd = { "clangd", "--experimental-modules-support" },
        server = { on_attach = lsp_on_attach },
        capabilities = capabilities
    }
    vim.lsp.config("clangd", cfg)
end

return { ConfigureCEDev = CEDev, ConfigureNormal = Normal }
