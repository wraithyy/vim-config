
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function () vim.cmd("Neotree position=current reveal=true source=filesystem") end, { desc = "Open Explorer" })
	
vim.api.nvim_set_keymap('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>',
	{ desc = "Code Action", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>',
	{ desc = "Show Problems", noremap = true, silent = true })
vim.keymap.set('n', '<space>', '<nop>')
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

vim.keymap.set("n", "<leader>j", vim.lsp.buf.format, { desc = "Format Document" })
-- Drag line --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Move page down and center --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Move page up and center --
vim.keymap.set("n", "<C-u>", "<C-u>zz") 
-- ctrl c to excape --
vim.keymap.set("i", "<C-c>", "<Esc>")
-- make it rain --
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it Rain" })
-- go to previous buffer -- 
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- go to next buffer -- 
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- movement to end and beginning of line --
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
