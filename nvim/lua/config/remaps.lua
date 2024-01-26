vim.g.mapleader = " "

-- vim windows
vim.keymap.set("n", "<A-left>", function() vim.cmd.wincmd "<" end)
vim.keymap.set("n", "<A-right>", function() vim.cmd.wincmd ">" end)
vim.keymap.set("n", "<A-up>", function() vim.cmd.wincmd "-" end)
vim.keymap.set("n", "<A-down>", function() vim.cmd.wincmd "+" end)

-- nvim tree
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeOpen)
