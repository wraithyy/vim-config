return {
	"yetone/avante.nvim",
	lazy = true,
	command = { "AvanteAsk", "AvanteChat" },
	version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
	opts = {
		behaviour = {
			auto_suggestions = false, -- Experimental stage
		},
		-- add any opts here
		file_selector = {
			--- @alias FileSelectorProvider "native" | "fzf" | "telescope" | string
			provider = "telescope",
			-- Options override for custom providers
			provider_opts = {},
		},
		-- provider = "ollama",
		vendors = {
			ollama = {
				__inherited_from = "openai",
				api_key_name = "",
				endpoint = "http://127.0.0.1:11434/v1",
				-- model = "codellama:13b",
				model = "deepseek-coder:6.7b",
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.icons",
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			lazy = true,
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
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "Avante" },
			},
			ft = { "Avante" },
		},
	},
}
