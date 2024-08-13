vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Explorer" })
-- Number remaps -- 
vim.api.nvim_set_keymap('n', '+', '1', { noremap = true })
vim.api.nvim_set_keymap('n', 'ě', '2', { noremap = true })
vim.api.nvim_set_keymap('n', 'š', '3', { noremap = true })
vim.api.nvim_set_keymap('n', 'č', '4', { noremap = true })
vim.api.nvim_set_keymap('n', 'ř', '5', { noremap = true })
vim.api.nvim_set_keymap('n', 'ž', '6', { noremap = true })
vim.api.nvim_set_keymap('n', 'ý', '7', { noremap = true })
vim.api.nvim_set_keymap('n', 'á', '8', { noremap = true })
vim.api.nvim_set_keymap('n', 'í', '9', { noremap = true })
vim.api.nvim_set_keymap('n', 'é', '0', { noremap = true })
vim.api.nvim_set_keymap('n', 'ú', '/', { noremap = true })
vim.api.nvim_set_keymap('n', 'ů', ';', { noremap = true })

vim.api.nvim_set_keymap('n', '9', '{', { noremap = true })
vim.api.nvim_set_keymap('n', '0', '}', { noremap = true })
