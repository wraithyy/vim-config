return {
	{
		'lewis6991/gitsigns.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }, -- Závislost, která je vyžadována
		config = function()
			require('gitsigns').setup({
				signs                   = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signcolumn              = true, -- Zobrazení gitsigns ve sloupci se značkami
				sign_priority           = 100,
				numhl                   = false, -- Povolit/zakázat zvýraznění čísla řádku
				linehl                  = false, -- Povolit/zakázat zvýraznění celého řádku
				watch_gitdir            = {
					interval = 1000,
				},
				current_line_blame      = true, -- Zobrazit blame na aktuálním řádku
				current_line_blame_opts = {
					delay = 1000,
				},
				update_debounce         = 100,
				status_formatter        = nil, -- Můžete přizpůsobit formátování stavu
				max_file_length         = 40000, -- Maximální délka souboru pro zobrazení gitsigns
			})
			vim.api.nvim_set_keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>',
				{ noremap = true, silent = true, desc = "Stage Hunk" })
			vim.api.nvim_set_keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>',
				{ noremap = true, silent = true, desc = "Reset Hunk" })
			vim.api.nvim_set_keymap('n', '<leader>hb', ':Gitsigns blame_line<CR>',
				{ noremap = true, silent = true, desc = "Blame Line" })
			vim.api.nvim_set_keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>',
				{ noremap = true, silent = true, desc = "Preview Hunk" })
		end,
	},
}
