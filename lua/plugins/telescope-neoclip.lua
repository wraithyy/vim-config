return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		lazy = true,
		config = function()
			require("neoclip").setup({
				history = 1000, -- Počet položek v historii
				length_limit = 1048576, -- Maximální délka položky v historii
				continuous_sync = true, -- Kontinuální synchronizace historie
				filter = nil, -- Volitelný filtr položek
				preset = "helix",
				preview = true, -- Náhled obsahu při procházení historie
				default_register = '"', -- Výchozí registr pro ukládání
				default_register_macros = "q", -- Výchozí registr pro makra
				enable_macro_history = true, -- Uloží historii maker
				enable_persistent_history = true,
				content_spec_column = false, -- Nepoužívat sloupec pro zobrazení obsahu v Teleskope
				on_paste = {
					set_reg = true, -- Nastaví registr při vložení
				},
				on_replay = {
					set_reg = true, -- Nastaví registr při přehrávání maker
				},
				keys = {
					telescope = {
						i = {
							select = "<cr>", -- Výběr položky
							paste = "<c-p>", -- Vložit vybranou položku
							paste_behind = "<c-k>", -- Vložit vybranou položku za aktuální řádek
							replay = "<c-q>", -- Přehraj makro
							delete = "<c-d>", -- Odstranit položku
						},
						n = {
							select = "<cr>",
							paste = "p",
							paste_behind = "P",
							replay = "q",
							delete = "d",
						},
					},
				},
			})

			-- Příkaz pro zobrazení historie v Teleskope
			require("telescope").load_extension("neoclip")
			vim.keymap.set(
				"n",
				"<leader>fc",
				"<cmd>Telescope neoclip<CR>",
				{ noremap = true, silent = true, desc = "Open Neoclip" }
			)
		end,
	},
}
