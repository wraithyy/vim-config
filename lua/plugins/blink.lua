return {
	"saghen/blink.cmp",
	enabled = true,
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
		},
		"mikavilpas/blink-ripgrep.nvim",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = { "lsp", "path", "buffer", "snippets", "buffer", "ripgrep" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					-- kind = "LSP",
					-- When linking markdown notes, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no LSP
					-- suggestions
					-- Disabling fallbacks as my snippets woudlnt show up
					-- fallbacks = { "luasnip", "buffer" },
					score_offset = 90, -- the higher the number, the higher the priority
				},
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 4,
					module = "blink.cmp.sources.snippets",
					min_keyword_length = 3,
					score_offset = 85, -- the higher the number, the higher the priority
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 30,
					-- When typing a path, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no path
					-- suggestions
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 4,
					score_offset = 20,
				},
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					score_offset = 15,
					-- the options below are optional, some default values are shown
					---@module "blink-ripgrep"
					---@type blink-ripgrep.Options
					transform_items = function(_, items)
						for _, item in ipairs(items) do
							-- example: append a description to easily distinguish rg results
							item.labelDetails = {
								description = "(rg)",
							}
						end
						return items
					end,
				},
				-- Example on how to configure dadbod found in the main repo
				-- https://github.com/kristijanhusak/vim-dadbod-completion
				-- dadbod = {
				-- 	name = "Dadbod",
				-- 	module = "vim_dadbod_completion.blink",
				-- 	score_offset = 85, -- the higher the number, the higher the priority
				-- },
				-- Third class citizen mf always talking shit
				-- copilot = {
				-- 	name = "copilot",
				-- 	enabled = true,
				-- 	module = "blink-cmp-copilot",
				-- 	-- kind = "Copilot",
				-- 	min_keyword_length = 6,
				-- 	score_offset = -100, -- the higher the number, the higher the priority
				-- 	async = true,
				-- },
			},
			-- command line completion, thanks to dpetka2001 in reddit
			-- https://www.reddit.com/r/neovim/comments/1hjjf21/comment/m37fe4d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
			cmdline = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
		snippets = {
			preset = "luasnip",
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},

		keymap = {
			preset = "enter",
			["<C-S-Space>"] = { "show" },
			["<S-CR>"] = { "hide" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down" },
			["<PageUp>"] = { "scroll_documentation_up" },
			cmdline = {
				["<Tab>"] = { "accept" },
			},
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 2 },
						{ "kind_icon", gap = 1, "kind" },
					},
				},
			},
			documentation = { window = { border = "rounded" }, auto_show = true, auto_show_delay_ms = 500 },
		},

		signature = { window = { border = "rounded" } },
	},
}
