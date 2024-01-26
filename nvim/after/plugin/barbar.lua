-- Move to previous/next
vim.keymap.set('n', '<C-b>,', vim.cmd.BufferPrevious)
vim.keymap.set('n', '<C-b>.', vim.cmd.BufferNext)
-- Re-order to previous/next
vim.keymap.set('n', '<C-b><', vim.cmd.BufferMovePrevious)
vim.keymap.set('n', '<C-b>>', vim.cmd.BufferMoveNext)
-- Goto buffer in position...
vim.keymap.set('n', '<C-b>1', function() vim.cmd.BufferGoto(1) end)
vim.keymap.set('n', '<C-b>2', function() vim.cmd.BufferGoto(2) end)
vim.keymap.set('n', '<C-b>3', function() vim.cmd.BufferGoto(3) end)
vim.keymap.set('n', '<C-b>4', function() vim.cmd.BufferGoto(4) end)
vim.keymap.set('n', '<C-b>5', function() vim.cmd.BufferGoto(5) end)
vim.keymap.set('n', '<C-b>6', function() vim.cmd.BufferGoto(6) end)
vim.keymap.set('n', '<C-b>7', function() vim.cmd.BufferGoto(7) end)
vim.keymap.set('n', '<C-b>8', function() vim.cmd.BufferGoto(8) end)
vim.keymap.set('n', '<C-b>9', function() vim.cmd.BufferGoto(9) end)
vim.keymap.set('n', '<C-b>0', vim.cmd.BufferLast)
-- Pin/unpin buffer
vim.keymap.set('n', '<C-b>p', vim.cmd.BufferPin)
-- Close buffer
vim.keymap.set('n', '<C-b>c', vim.cmd.BufferClose)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', vim.cmd.BufferPick)
-- Sort automatically by...
vim.keymap.set('n', '<C-b>b', vim.cmd.BufferOrderByBufferNumber)
vim.keymap.set('n', '<C-b>d', vim.cmd.BufferOrderByDirectory)
vim.keymap.set('n', '<C-b>l', vim.cmd.BufferOrderByLanguage)
vim.keymap.set('n', '<C-b>w', vim.cmd.BufferOrderByWindowNumber)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
