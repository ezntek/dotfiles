local function start_trouble_todos()
    vim.cmd.Trouble()

    -- put the todos into
    -- trouble
    vim.cmd.TodoTrouble()
end

-- some remaps
vim.keymap.set("n", "<leader>trt", start_trouble_todos)
vim.keymap.set("n", "<leader>trc", vim.cmd.TroubleClose)
vim.keymap.set("n", "<leader>tro", function()
    vim.cmd.Trouble "workspace_diagnostics"
end)
