return { {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Zde si nastavíš jazyky, které chceš používat
			ensure_installed = { "c", "lua", "python", "javascript", "typescript", "tsx" }, -- Přidej zde jazyky, které chceš
			sync_install = false,                                      -- Jazyky se budou instalovat asynchronně
			auto_install = true,                                       -- Automatická instalace chybějících parsers
			indent = { enable = true },
			highlight = {
				enable = true, -- Zapni zvýrazňování syntaxe
				additional_vim_regex_highlighting = false, -- Zakáže použití regex zvýraznění spolu s treesitter
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automaticky skočí dopředu k textovému objektu, podobně jako targets.vim
					keymaps = {
						-- Textové objekty
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@comment.outer',
						['ic'] = '@comment.inner',
						['al'] = '@loop.outer',
						['il'] = '@loop.inner',
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["it"] = "@tag.inner",
						["at"] = "@tag.outer",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["is"] = "@statement.inner",
						["as"] = "@statement.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Nastaví skoky v seznamu skoků
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			} }
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
