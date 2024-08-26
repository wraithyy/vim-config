return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			theme = "catppuccin-mocha" },
		config = function()
			local harpoon = require("harpoon.mark")

			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				-- Match the branch name to the specified format
				local user, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

				-- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return user .. "/" .. team .. "-" .. ticket_number
				else
					return branch
				end
			end

			local function harpoon_component()
				local total_marks = harpoon.get_length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				local mark_idx = harpoon.get_current_index()
				if mark_idx ~= nil then
					current_mark = tostring(mark_idx)
				end

				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "█", right = "█" },
				},
				sections = {
					lualine_b = {
						{ "branch", icon = "", fmt = truncate_branch_name },
						harpoon_component,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						"filetype",
					},
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			color_overrides = {
				all = {
					-- Map your custom colors to Catppuccin equivalents
					peach = "#ee5d43", -- Color5
					green = "#96E072", -- Color6
					mauve = "#c74ded", -- Color4
					teal = "#00e8c6", -- Color1
					overlay0 = "#808085", -- Color0
					yellow = "#FFE66D", -- Color3
					orange = "#f39c12", -- Color2
				},
			},
			custom_highlights = function(colors)
				return {
					-- Apply specific colors from Catppuccin's palette based on your example
					Comment = { fg = colors.overlay0 }, -- Color0 mapped to overlay0
					Identifier = { fg = colors.teal }, -- Color1 mapped to teal
					Number = { fg = colors.peach }, -- Color2 mapped to peach
					Function = { fg = colors.yellow }, -- Color3 mapped to yellow
					Type = { fg = colors.mauve }, -- Color4 mapped to mauve
					Keyword = { fg = colors.mauve }, -- Color4 mapped to mauve
					Constant = { fg = colors.peach }, -- Color5 mapped to peach
					String = { fg = colors.green }, -- Color6 mapped to green

					-- Variables (updated to use colors.teal)
					TSVariable = { fg = colors.teal }, -- Variable names
					["@variable"] = { fg = colors.teal }, -- Variable names
					["@parameter"] = { fg = colors.teal }, -- Variable names
					["@variable.builtin"] = { fg = colors.teal }, -- Variable names
					["@variable.member"] = { fg = colors.yellow }, -- Variable names
					TSParameter = { fg = colors.teal }, -- Parameter names
					["@property"] = { fg = colors.teal }, -- Property names:
					["@type"] = { fg = colors.yellow }, -- Type names
					["@type.builtin"] = { fg = colors.overlay0 }, -- Type names
					Special = { fg = colors.peach }, -- Special characters
					["@tag"] = { fg = colors.peach }, -- Tag names
					["@tag.attribute.tsx"] = { fg = colors.yellow }, -- Tag names


					-- Line numbers
					LineNr = { fg = colors.teal }, -- Regular line numbers
					CursorLineNr = { fg = colors.teal }, -- Current line number

					-- Additional highlights directly with colors based on your Lua theme example
					WinSeparator = { fg = colors.teal }, -- Window separators
					TSLabel = { fg = colors.mauve }, -- Type color
					TSProperty = { fg = colors.peach }, -- Constant color
					TSConstBuiltin = { fg = colors.peach }, -- Constant color
					Folded = { fg = colors.overlay0}, -- Comment color for folded text
					TSField = { fg = colors.teal }, -- Field names as variables
					TSPunctBracket = { fg = colors.mauve }, -- Type color
					Repeat = { fg = colors.mauve }, -- Type color
					NonText = { fg = colors.overlay0 }, -- Comment color for non-text elements
					TSFunction = { fg = colors.yellow }, -- Function color
					TSNumber = { fg = colors.peach }, -- Number color
					TSKeyword = { fg = colors.mauve }, -- Keyword color
					TSTagDelimiter = { fg = colors.mauve }, -- Type color
					TelescopeNormal = { fg = colors.text, bg = colors.mantle }, -- Normal colors for Telescope
					TSConstant = { fg = colors.peach }, -- Constant color
					TSOperator = { fg = colors.peach }, -- Operator color
					TSConditional = { fg = colors.mauve }, -- Keyword color
					TSType = { fg = colors.mauve }, -- Type color
					TSNamespace = { fg = colors.mauve }, -- Type color
					Whitespace = { fg = colors.overlay0 }, -- Comment color for whitespace
					TSFuncMacro = { fg = colors.yellow }, -- Function color for macros
					Operator = { fg = colors.peach }, -- Keyword color for operators
					TSParameterReference = { fg = colors.teal }, -- Variables (parameters) in references
					TSString = { fg = colors.green }, -- String color
					Macro = { fg = colors.yellow }, -- Function color
					TSFloat = { fg = colors.peach }, -- Number color for floats
					TSRepeat = { fg = colors.mauve }, -- Keyword color for repeats
					TSComment = { fg = colors.overlay0 }, -- Comment color
					TSTag = { fg = colors.mauve }, -- Type color for tags
					TSPunctSpecial = { fg = colors.overlay1 }, -- Punctuation special color
					Conditional = { fg = colors.mauve }, -- Keyword color for conditionals
					WilderMauve = { fg = colors.teal }, -- Wilder highlight color
					WilderText = { fg = colors.text, bg=colors.overlay0 }, -- Wilder highlight color

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
			config = function()
				vim.defer_fn(function()
					vim.cmd.colorscheme("catppuccin") -- Set Catppuccin as the colorscheme after configuration
				end, 0)
			end
		}
	},
	"rcarriga/nvim-notify",
}
