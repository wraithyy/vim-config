return {
	'rmagatti/auto-session',
	lazy = false,
	dependencies = {
		'nvim-telescope/telescope.nvim',
	},
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ '<leader>sr', '<cmd>SessionSearch<CR>',         desc = 'Session search' },
		{ '<leader>ss', '<cmd>SessionSave<CR>',           desc = 'Save session' },
		{ '<leader>sa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
	},

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- ⚠️ This will only work if Telescope.nvim is installed
		-- The following are already the default values, no need to provide them if these are already the settings you want.
		bypass_save_filetypes = { 'alpha', 'dashboard' },
		session_lens = {
			-- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
			load_on_setup = true,
			previewer = false,
			mappings = {
				-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
				delete_session = { "i", "<C-D>" },
				alternate_session = { "i", "<C-S>" },

			},
			-- Can also set some Telescope picker options
			theme_conf = {
				border = true,
				-- layout_config = {
				--   width = 0.8, -- Can set width and height as percent of window
				--   height = 0.5,
				-- },
			},
		},
	}
}