return {
	"goolord/alpha-nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"rmagatti/auto-session", -- Plugin pro automatickou správu relací
		"nvim-telescope/telescope.nvim", -- Telescope jako závislost pro session-lens
		"BlakeJC94/alpha-nvim-fortune",
	},
	cmd = "Alpha",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local project = require("telescope._extensions.project.utils")
		local fortune = require("alpha.fortune")
		-- Změna loga na "Wraithy"
		dashboard.section.header.val = {
			[[ █     █░ ██▀███   ▄▄▄       ██▓▄▄▄█████▓ ██░ ██▓██   ██▓]],
			[[▓█░ █ ░█░▓██ ▒ ██▒▒████▄    ▓██▒▓  ██▒ ▓▒▓██░ ██▒▒██  ██▒]],
			[[▒█░ █ ░█ ▓██ ░▄█ ▒▒██  ▀█▄  ▒██▒▒ ▓██░ ▒░▒██▀▀██░ ▒██ ██░]],
			[[░█░ █ ░█ ▒██▀▀█▄  ░██▄▄▄▄██ ░██░░ ▓██▓ ░ ░▓█ ░██  ░ ▐██▓░]],
			[[░░██▒██▓ ░██▓ ▒██▒ ▓█   ▓██▒░██░  ▒██▒ ░ ░▓█▒░██▓ ░ ██▒▓░]],
			[[░ ▓░▒ ▒  ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░▓    ▒ ░░    ▒ ░░▒░▒  ██▒▒▒ ]],
			[[  ▒ ░ ░    ░▒ ░ ▒░  ▒   ▒▒ ░ ▒ ░    ░     ▒ ░▒░ ░▓██ ░▒░ ]],
			[[  ░   ░    ░░   ░   ░   ▒    ▒ ░  ░       ░  ░░ ░▒ ▒ ░░  ]],
			[[    ░       ░           ░  ░ ░            ░  ░  ░░ ░     ]],
			[[                                                 ░ ░     ]],
		}
		-- Načtení posledních 5 projektů z Telescope Project
		local function get_recent_projects()
			local projects = {}
			local project_dirs = project.get_projects()

			for i, proj in ipairs(project_dirs) do
				if i > 5 then
					break
				end
				local project_name = vim.fn.fnamemodify(proj.path, ":t")
				table.insert(
					projects,
					dashboard.button(
						tostring(i),
						"  " .. project_name,
						":Neotree source=filesystem position=current " .. proj.path .. " <CR>"
					)
				)
			end
			return projects
		end
		dashboard.section.projects = {
			type = "group",
			val = vim.list_extend({
				{ type = "text", val = "Recent Projects", opts = { hl = "Title", position = "center" } },
			}, get_recent_projects()),
			opts = {},
		}

		-- Přidání tlačítek pro různé funkce
		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
			dashboard.button("b", "  Browse files", ":Neotree source=filesystem reveal=true position=current <CR>"),
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("p", "  Find Project", ":Telescope project <CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("s", "  Sessions", ":Telescope session-lens <CR>"),
			dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
			dashboard.button("c", "  Config", ":Neotree source=filesystem position=current ~/.config/nvim/ <CR>"),
			dashboard.button(
				"d",
				"  Development Folders",
				":Neotree source=filesystem position=current: ~/Development/ <CR>"
			),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		dashboard.section.footer.val = fortune()

		-- Nastavení dashboardu
		alpha.setup({
			layout = {
				{ type = "padding", val = 1 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
				{ type = "padding", val = 2 },
				dashboard.section.projects, -- přidání recent projects group
			},
			opts = {},
		})

		require("telescope").load_extension("session-lens")
		-- Disable folding on alpha buffer
	end,
}
