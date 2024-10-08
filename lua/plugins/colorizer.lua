require("which-key").add({
	{ "<leader>c", desc = "Colorizer toggle", icon = { icon = "", color = "purple" } },
})
return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		}, {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		})

		-- Optional: Keybinding to toggle Colorizer
		vim.keymap.set("n", "<leader>c", ":ColorizerToggle<CR>", { noremap = true, silent = true })
	end,
}
