return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "html" },
	lazy = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {}, -- your configuration
}
