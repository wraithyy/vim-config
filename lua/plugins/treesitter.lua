return { {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Zde si nastavíš jazyky, které chceš používat
			ensure_installed = { "c", "lua", "python", "javascript", "typescript" }, -- Přidej zde jazyky, které chceš
			sync_install = false,                               -- Jazyky se budou instalovat asynchronně
			auto_install = true,                                -- Automatická instalace chybějících parsers
			indent = { enable = true },
			highlight = {
				enable = true, -- Zapni zvýrazňování syntaxe
				additional_vim_regex_highlighting = false, -- Zakáže použití regex zvýraznění spolu s treesitter
			},
		}
	end,
},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	}
	, }
