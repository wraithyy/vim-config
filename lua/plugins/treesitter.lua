require("which-key").add({
	{ "<leader>t", desc = "Treesitter/Twoslash", icon = "" },
	{ "<leader>ti", desc = "Initialize Treesitter selection", icon = "" },
	{ "<leader>tn", desc = "Next Treesitter selection (increment)", icon = "" },
	{ "<leader>tp", desc = "Previous Treesitter selection (decrement)", icon = "" },
})
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Zde si nastavíš jazyky, které chceš používat
				ensure_installed = {
					"c",
					"lua",
					"python",
					"javascript",
					"typescript",
					"tsx",
					"markdown",
					"markdown_inline",
				}, -- Přidej zde jazyky, které chceš
				sync_install = false, -- Jazyky se budou instalovat asynchronně
				auto_install = true, -- Automatická instalace chybějících parsers
				indent = { enable = true },
				highlight = {
					enable = true, -- Zapni zvýrazňování syntaxe
					additional_vim_regex_highlighting = false, -- Zakáže použití regex zvýraznění spolu s treesitter
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>ti",
						node_incremental = "<leader>tn",
						scope_incremental = false,
						node_decremental = "<leader>tp",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automaticky skočí dopředu k textovému objektu, podobně jako targets.vim
						keymaps = {
							-- Textové objekty
							["a="] = "@assignment.outer",
							["i="] = "@assignment.inner",
							["r="] = "@assignment.rhs",
							["l="] = "@assignement.lhs",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@comment.outer",
							["ic"] = "@comment.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["it"] = "@tag.inner",
							["at"] = "@tag.outer",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["is"] = "@statement.inner",
							["as"] = "@statement.outer",
							["aB"] = "@call.outer",
							["iB"] = "@call.inner",
							["av"] = "@variable.outer",
							["iv"] = "@variable.inner",
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
				},
			})
		end,
	},
}
