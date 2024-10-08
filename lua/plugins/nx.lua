require("which-key").add({
	{ "<leader>nx", desc = "Open NX actions", icon = "" },
	{ "<leader>n", desc = "Nx actions", icon = "" },
})
return {
	"Equilibris/nx.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local nx = require("nx")

		nx.setup({
			nx_cmd_root = "npx nx", -- Set the command root
			command_runner = require("nx.command-runners").toggleterm_runner({ c }),
		})

		-- Keybinding to open Telescope for nx actions
		vim.keymap.set(
			"n",
			"<leader>nx",
			"<cmd>Telescope nx actions<CR>",
			{ noremap = true, silent = true, desc = "Open nx actions" }
		)
	end,
}
