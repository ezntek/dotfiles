local function new()
    local ts = require 'nvim-treesitter'

    local items = {
        ["c"] = "c",
        ["cpp"] = "cpp",
        ["odin"] = "odin",
        ["cs"] = "c_sharp",
        ["lua"] = "lua",
        ["vim"] = "vim",
        ["rust"] = "rust",
        ["python"] = "python",
        ["zig"] = "zig",
        ["nasm"] = "nasm",
        ["c3"] = "c3",
        ["pascal"] = "pascal",
        ["java"] = "java",
        ["javascript"] = "javascript",
        ["typescript"] = "typescript",
        ["svelte"] = "svelte",
        ["ruby"] = "ruby",
        ["d"] = "d",
        ["go"] = "go",
        ["css"] = "css",
        ["html"] = "html",
        ["tex"] = "latex",
        ["sql"] = "sql",
        ["json"] = "json",
        ["toml"] = "toml",
        ["yaml"] = "yaml",
        ["xml"] = "xml",
    }

    ts.install(items)

    for ft, _ in pairs(items) do
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { ft },
            callback = function() vim.treesitter.start() end,
        })
    end

    vim.filetype.add {
        extension = {
            inc = "nasm",
            s = "nasm",
            fasm = "asm",
        },
    }
end

--old()
new()
