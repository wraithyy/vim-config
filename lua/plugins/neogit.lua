return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		require('neogit').setup({
			integrations = {
				diffview = true -- Enable integration with Diffview
			}
		})
		vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit kind=vsplit<CR>', { noremap = true, silent = true, desc = 'Open Neogit Status' })
      vim.api.nvim_set_keymap('n', '<leader>gc', ':Neogit commit<CR>', { noremap = true, silent = true, desc = 'Open Neogit Commit' })
      vim.api.nvim_set_keymap('n', '<leader>gp', ':Neogit push<CR>', { noremap = true, silent = true, desc = 'Push Changes' })
      vim.api.nvim_set_keymap('n', '<leader>gr', ':Neogit rebase<CR>', { noremap = true, silent = true, desc = 'Rebase' })
      vim.api.nvim_set_keymap('n', '<leader>gm', ':Neogit merge<CR>', { noremap = true, silent = true, desc = 'Merge Branch' })
      vim.api.nvim_set_keymap('n', '<leader>gC', ':Neogit cherry_pick<CR>', { noremap = true, silent = true, desc = 'Cherry-pick Commit' })

      -- Diffview shortcuts for advanced diffing
      vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewOpen<CR>', { noremap = true, silent = true, desc = 'Open Diffview' })
      vim.api.nvim_set_keymap('n', '<leader>gq', ':DiffviewClose<CR>', { noremap = true, silent = true, desc = 'Close Diffview' })
      vim.api.nvim_set_keymap('n', '<leader>gh', ':DiffviewFileHistory<CR>', { noremap = true, silent = true, desc = 'File History' })
	end
}
