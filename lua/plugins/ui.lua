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
