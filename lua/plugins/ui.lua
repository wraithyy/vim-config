return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			theme="catppuccin-mocha"},
		},
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 , integrations = {
			telescope = true,
			alpha = true,neogit = true}},
			{ 'echasnovski/mini.icons', version = false },
		}
