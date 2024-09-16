return {
	{
		'lewis6991/gitsigns.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }, -- Závislost, která je vyžadována
		config = function()
			require('gitsigns').setup({
				current_line_blame = true,
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
