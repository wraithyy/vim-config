require("which-key").add({
	{ "<leader>m", desc = "Markdown", icon = "" },
	{ "<leader>mv", desc = "Markview toggle", icon = "" },
})
return {
	"OXY2DEV/markview.nvim",
	lazy = true, -- Recommended
	ft = { "markdown", "Avante" }, -- If you decide to lazy-load anyway

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local presets = require("markview.presets")
		require("markview").setup({
			checkboxes = presets.checkboxes.nerd,
			headings = presets.headings.marker,
			horizontal_rules = presets.horizontal_rules.thick,
			filetypes = { "markdown", "quarto", "rmd" },
		})
		vim.keymap.set(
			"n",
			"<leader>mv",
			":Markview toggleAll<CR>",
			{ noremap = true, silent = true, desc = "Toggle markview" }
		)
	end,
}
