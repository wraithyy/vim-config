return {
	"Al0den/notion.nvim",
	lazy = false, --Should work when lazy loaded, not tested
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require "notion".setup()
				vim.keymap.set('n', '<leader>no', function() require "notion".openMenu() end,
					{  desc = 'Open Notion' })
	end,
}
