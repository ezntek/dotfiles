local function start_trouble()
    vim.cmd.Trouble()

    -- put the todos into
    -- trouble
    vim.cmd.TodoTrouble()
end

-- some remaps
vim.keymap.set("n", "<leader>tro", start_trouble)
vim.keymap.set("n", "<leader>trc", vim.cmd.TroubleClose)
