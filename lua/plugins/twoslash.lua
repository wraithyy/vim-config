require("which-key").add({
	{ "<leader>ts", desc = "Two Slash Query", icon = "󱜹" },
})
return {
	"marilari88/twoslash-queries.nvim",
	config = function()
		vim.keymap.set(
			"n",
			"<leader>ts",
			":TwoslashQueryEnable<CR>",
			{ noremap = true, silent = true, desc = "Two Slash Query" }
		)
		require("twoslash-queries").setup({
			highlight = "Type", -- to set up a highlight group for the virtual text
		})
	end,
}
