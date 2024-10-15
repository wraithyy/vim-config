return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	lazy = true,
	event = "BufRead",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = { theme = "catppuccin-mocha" },
}
