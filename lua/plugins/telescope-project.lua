return {
	"nvim-telescope/telescope-project.nvim",
	dependencies = { 
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim"  -- Plenary je nezbytná závislost pro Telescope
	},
	config = function()
		require('telescope').load_extension('project')
		vim.keymap.set("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, silent = true , desc = "Find project"})

	end
}
