return {
	"ecthelionvi/NeoComposer.nvim",
	dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
	config = function()
		require("NeoComposer").setup()
		require('telescope').load_extension('macros')
		vim.keymap.set("n", "<leader>fm", ":Telescope macros<CR>", { noremap = true, silent = true , desc = "Find macros"})
	end



}
