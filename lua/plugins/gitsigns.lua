require("which-key").add({
	{ "<leader>gh", desc = "GitSigns", icon = { icon = "󰞁", color = "red" } },
	{ "<leader>ghs", desc = "Stage Hunk", icon = { icon = "󰥝", color = "orange" } },
	{ "<leader>ghr", desc = "Reset Hunk", icon = { icon = "󰆴", color = "red" } },
	{ "<leader>ghp", desc = "Preview Hunk", icon = "" },
	{ "<leader>ghb", desc = "Blame Line", icon = "󰱩" },
})
return {
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }, -- Závislost, která je vyžadována
		config = function()
			require("gitsigns").setup({})
			vim.keymap.set(
				"n",
				"<leader>ghs",
				":Gitsigns stage_hunk<CR>",
				{ noremap = true, silent = true, desc = "Stage Hunk" }
			)
			vim.keymap.set(
				"n",
				"<leader>ghr",
				":Gitsigns reset_hunk<CR>",
				{ noremap = true, silent = true, desc = "Reset Hunk" }
			)
			vim.keymap.set(
				"n",
				"<leader>ghb",
				":Gitsigns blame_line<CR>",
				{ noremap = true, silent = true, desc = "Blame Line" }
			)
			vim.keymap.set(
				"n",
				"<leader>ghp",
				":Gitsigns preview_hunk<CR>",
				{ noremap = true, silent = true, desc = "Preview Hunk" }
			)
		end,
	},
}
