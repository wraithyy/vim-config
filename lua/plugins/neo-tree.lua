require("which-key").add({
	{ "<leader>e", desc = "NeoTree", icon = "" },
	{ "<leader>ee", desc = "Open/focus Neotree", icon = { icon = "󱞊", color = "green" } },
	{ "<leader>et", desc = "Toggle Neotree", icon = "" },
})
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
			local get_path = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					return node.path
				end
				return node:get_parent_id()
			end

			local do_setcd = function(state)
				local p = get_path(state)
				vim.cmd(string.format('exec(":lcd %s")', p))
				return p
			end
			require("neo-tree").setup({
				close_if_last_window = true, -- Zavře neo-tree pokud je posledním oknem
				popup_border_style = "rounded", -- Styl ohraničení pop-up oken
				enable_git_status = true, -- Zobrazení Git statusu
				enable_diagnostics = true, -- Zobrazení diagnostických informací
				commands = {
					spectre = function(state)
						local p = do_setcd(state)
						require("spectre").open({
							is_insert_mode = true,
							cwd = p,
							is_close = false,
						})
						vim.cmd("Neotree close")
					end,
				},
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
					width = 50, -- Šířka okna
					mappings = {
						["<leader>r"] = "spectre",
					},
				},
				buffers = {
					follow_current_file = { enabled = true }, -- Sleduje aktuálně otevřený soubor v bufferu
				},
				git_status = {
					window = {
						position = "float",
					},
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
			vim.keymap.set(
				"n",
				"<leader>et",
				":Neotree toggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle files" }
			)
			vim.keymap.set(
				"n",
				"<leader>ee",
				":lua FocusOrOpenNeoTree()<CR>",
				{ noremap = true, silent = true, desc = "Focus Neo-Tree sidebar" }
			)
			vim.keymap.set(
				"n",
				"<leader>gs",
				":Neotree float git_status<CR>",
				{ noremap = true, silent = true, desc = "Git status" }
			)
		end,
	},
}
