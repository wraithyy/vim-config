return {"tveskag/nvim-blame-line", config = function() 
vim.keymap.set("n", "<leader>b", ":ToggleBlameLine<CR>", { noremap = true, silent = true, desc = "Toggle blame line" })
end}
