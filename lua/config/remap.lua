vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function()
	vim.cmd("Neotree position=current reveal=true source=filesystem")
end, { desc = "Open Explorer" })

vim.keymap.set(
	"n",
	"<leader>.",
	"<cmd>lua vim.lsp.buf.code_action()<CR>",
	{ desc = "Code Action", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>,",
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	{ desc = "Show Problems", noremap = true, silent = true }
)
vim.keymap.set("n", "<space>", "<nop>")
-- Number remaps --
vim.keymap.set("n", "+", "1", { noremap = true })
vim.keymap.set("n", "ě", "2", { noremap = true })
vim.keymap.set("n", "š", "3", { noremap = true })
vim.keymap.set("n", "č", "4", { noremap = true })
vim.keymap.set("n", "ř", "5", { noremap = true })
vim.keymap.set("n", "ž", "6", { noremap = true })
vim.keymap.set("n", "ý", "7", { noremap = true })
vim.keymap.set("n", "á", "8", { noremap = true })
vim.keymap.set("n", "í", "9", { noremap = true })
vim.keymap.set("n", "é", "0", { noremap = true })
vim.keymap.set("n", "ú", "/", { noremap = true })
vim.keymap.set("n", "ů", ";", { noremap = true })

vim.keymap.set("n", "9", "{", { noremap = true })
vim.keymap.set("n", "0", "}", { noremap = true })

vim.keymap.set("n", "<leader>j", vim.lsp.buf.format, { desc = "Format Document" })
-- Drag line --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Move page down and center --
--vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Move page up and center --
--vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- ctrl c to excape --
vim.keymap.set("i", "<C-c>", "<Esc>")
-- go to previous buffer --
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- go to next buffer --
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- delete without yank --
vim.keymap.set("n", "<leader>dd", '"_d', { desc = "Delete without yank" })
vim.keymap.set("n", "<leader>pp", '"_dP', { desc = "Paste without yank" })
-- movement to end and beginning of line --
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")
--Terminal--
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jj", [[<C-\><C-n>]])
-- Window navigation from terminal
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
vim.keymap.set("n", "§", "`", { noremap = true, silent = true })

require("which-key").add({
	{ "<leader>p", desc = "Explorer/paste" },
	{ "<leader>pv", desc = "Explorer", icon = "" },
	{ "<leader>pp", desc = "Paste without yank", icon = "" },
	{ "<leader>d", desc = "Delete without yank", icon = "" },
	{ "<leader>dd", desc = "Delete without yank", icon = "" },
	{ "<leader>b", desc = "Buffer select", icon = "" },
	{ "<leader>bp", desc = "Previous buffer", icon = "" },
	{ "<leader>bn", desc = "Next buffer", icon = "" },
})
