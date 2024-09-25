return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				duration = 150,
				style = "#80a0b5",
			},
			indent = {
				enable = true,
				style = "#212121",
			},
		})
	end,
}
