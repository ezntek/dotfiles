local builtin = require "telescope.builtin"

local function telescope_grep()
    builtin.grep_string { search = vim.fn.input "telescope 🔍 " }
end

vim.keymap.set('n', "<leader>tff", builtin.find_files, {})
vim.keymap.set('n', "<leader>tgf", builtin.git_files, {})
vim.keymap.set('n', "<leader>tgr", telescope_grep, {})
vim.keymap.set("n", "<leader>tdt", vim.cmd.TodoTelescope, {})
