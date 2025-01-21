return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			presets = {
				long_message_to_split = true, -- long messages will be sent to a split
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			-- lsp = {
			-- 	signature = {
			-- 		enabled = false,
			-- 	},
			-- },
			routes = {
				{
					filter = {
						event = "notify",
						kind = "error",
					},
					view = "mini", -- použijte zkrácené zobrazení
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					backend = "cmp",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		})
	end,
}
