-- assuming FASM

vim.keymap.set('n', "<leader>fc", function()
    vim.cmd "Run fasm %"
    vim.cmd "wincmd p"
end, {})

vim.keymap.set('n', "<leader>fr", function()
    vim.cmd 'w'
    vim.cmd "Run fasm %"
    vim.cmd "wincmd p"
    local filepath = vim.api.nvim_buf_get_name(0)
    local exepath = filepath:match("(.+)%..+$")
    vim.cmd("Run " .. exepath)
end, {})
