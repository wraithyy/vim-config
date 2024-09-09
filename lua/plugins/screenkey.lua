return {
	"NStefan002/screenkey.nvim",
	branch = "main",
	cmd = "Screenkey",
	config = function()
		require("screenkey").setup({
			win_opts = {
				relative = "editor",
				anchor = "SE",
				width = 40,
				height = 1,
				border = "single",
				

			},
			compress_after = 3,
			clear_after = 3,
			show_leader = true,
			group_mappings = true,
		})
	end,
}
