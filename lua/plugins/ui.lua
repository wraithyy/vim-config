return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			theme = "catppuccin-mocha" },
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			custom_highlights = function(colors)
				local u = require("catppuccin.utils.colors")
				return {
					LineNr = { fg = colors.teal }, -- Nastavení barvy pro LineNr na teal
					CmpBorder = { fg = colors.teal },
					FloatBorder = { fg = colors.teal },
					CursorLine = {
						bg = u.vary_color(
							{ latte = u.lighten(colors.mantle, 0.70, colors.base) },
							u.darken(colors.surface0, 0.64, colors.base)
						),
					},
				}
			end,
			integrations = {
				telescope = true,
				cmp = true,
				barbecue = {
					dim_dirname = true, -- directory name is dimmed by default
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				diffview = true,
				window_picker = true,
				neotree = true,
				harpoon = true,
				mason = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				alpha = true,
				notify = true,
				neogit = true,
			},
		}
	},
	"rcarriga/nvim-notify",
}
