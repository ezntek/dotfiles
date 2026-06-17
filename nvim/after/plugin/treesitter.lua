local function old()
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.c3 = {
        install_info = {
            url = "~/Sources/apps/tree-sitter-c3",
            files = { "src/parser.c", "src/scanner.c" },
        },
    }

    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            -- user added
            "rust",
            "python",
            "zig",
            "nasm",
            "sql",
            "pascal",
        },

        -- Install parsers synchronously (only applied to )
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have  CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the  filetype, you need to include  in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end

                if lang == "latex" then
                    return true
                end
            end,

            -- Setting this to true will run  and tree-sitter at the same time.
            -- Set this to  if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { "zig", "html", "nix", "pas", } },
    }

    vim.filetype.add {
        extension = {
            inc = "asm",
            s = "nasm",
            fasm = "asm",
        },
    }
end

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
