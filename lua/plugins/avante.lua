return {
	"yetone/avante.nvim",
	build = "make",

	event = { "BufReadPre", "BufNewFile" },
	cmd = "Avante",
	lazy = true,
	opts = {
		provider = "ollama",
		vendors = {
			---@type AvanteProvider
			ollama = {
				__inherited_from = "openai",
				endpoint = "127.0.0.1:11434/v1",
				model = "codellama:13b",
				api_key_name = "",
			},
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
