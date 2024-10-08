return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				start_in_insert = true,
				insert_mappings = true,
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = "1",
				persist_size = true,
				direction = "horizontal",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})
			-- Keybinding to toggle terminal window
			vim.keymap.set(
				"n",
				"<C-t>", -- Adjust this keybinding to your preference
				"<cmd>ToggleTerm<CR>",
				{ noremap = true, silent = true, desc = "Toggle terminal window" }
			)

			vim.keymap.set(
				"t",
				"<C-t>", -- Same keybinding for terminal mode
				"<cmd>ToggleTerm<CR>",
				{ noremap = true, silent = true, desc = "Toggle terminal window" }
			)
		end,
	},
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = function()
			local toggleterm_manager = require("toggleterm-manager")
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			toggleterm_manager.setup({
				attach_mappings = function(_, map)
					-- Custom action to swap terminals without closing them
					actions.select_default:replace(function(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						if selection then
							local term = selection.value
							-- Open the selected terminal in the current terminal window
							term:open(0, true)
						end
					end)
					return true
				end,
				mappings = { -- key mappings bound inside the telescope window
					i = {
						["<CR>"] = {
							action = require("toggleterm-manager").actions.toggle_term,
							exit_on_action = false,
						}, -- toggles terminal open/closed
						["<C-i>"] = {
							action = require("toggleterm-manager").actions.create_term,
							exit_on_action = false,
						}, -- creates a new terminal buffer
						["<C-d>"] = {
							action = require("toggleterm-manager").actions.delete_term,
							exit_on_action = false,
						}, -- deletes a terminal buffer
						["<C-r>"] = {
							action = require("toggleterm-manager").actions.rename_term,
							exit_on_action = false,
						}, -- provides a prompt to rename a terminal
					},
					n = {
						["<CR>"] = {
							action = require("toggleterm-manager").actions.toggle_term,
							exit_on_action = false,
						}, -- toggles terminal open/closed
						["<C-i>"] = {
							action = require("toggleterm-manager").actions.create_term,
							exit_on_action = false,
						}, -- creates a new terminal buffer
						["<C-d>"] = {
							action = require("toggleterm-manager").actions.delete_term,
							exit_on_action = false,
						}, -- deletes a terminal buffer
						["<C-r>"] = {
							action = require("toggleterm-manager").actions.rename_term,
							exit_on_action = false,
						}, -- provides a prompt to rename a terminal
					},
				},
			})

			-- Keybinding to open the Terminal Manager
			vim.keymap.set(
				"n",
				"<leader>ft",
				"<cmd>Telescope toggleterm_manager initial_mode=normal<CR>",
				{ noremap = true, silent = true, desc = "Open Terminal Manager" }
			)
		end,
	},
}
