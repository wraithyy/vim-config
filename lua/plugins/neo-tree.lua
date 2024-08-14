return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- volitelně, pro ikony
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require('neo-tree').setup({
				close_if_last_window = true, -- Zavře neo-tree pokud je posledním oknem
				popup_border_style = "rounded", -- Styl ohraničení pop-up oken
				enable_git_status = true, -- Zobrazení Git statusu
				enable_diagnostics = true, -- Zobrazení diagnostických informací
				filesystem = {
					hijack_netrw_behavior = "open_current",
					filtered_items = {
						visible = true, -- Zobrazení skrytých souborů
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
					follow_current_file = { enabled = true }, -- Sleduje aktuálně otevřený soubor
					use_libuv_file_watcher = true, -- Aktualizuje se při změně souboru v systému
				},
				window = {
					position = "left", -- Pozice okna
					width = 60, -- Šířka okna
				},
				buffers = {
					follow_current_file = { enabled = true }, -- Sleduje aktuálně otevřený soubor v bufferu
				},
				git_status = {
					window = {
						position = "float",
					}
				},
			})
			function FocusOrOpenNeoTree()
				local neo_tree = require("neo-tree")
				local win = vim.fn.bufwinnr("Neo-tree")
				if win == -1 then
					-- Neo-Tree není otevřený, otevře ho a zaměří
					vim.cmd("Neotree show focus")
				else
					-- Neo-Tree je již otevřený, zaměří na něj
					vim.cmd("Neotree focus")
				end
			end

			-- Klávesové zkratky pro rychlé otevření/uzavření neo-tree
			vim.api.nvim_set_keymap('n', '<leader>et', ':Neotree toggle<CR>',
				{ noremap = true, silent = true, desc = "Toggle files" })
			vim.api.nvim_set_keymap('n', '<leader>ee', ':lua FocusOrOpenNeoTree()<CR>',
				{ noremap = true, silent = true, desc = "Focus Neo-Tree sidebar" })
		end
	}
}
