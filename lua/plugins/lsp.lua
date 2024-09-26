local function lsp_highlight_document(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "lsp_document_highlight",

			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = 0,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end
end
return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "rafamadriz/friendly-snippets" }, -- Optional
			{ "onsails/lspkind.nvim" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "marilari88/twoslash-queries.nvim" },
			-- Telescope for fuzzy finding
			{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		config = function()
			-- Setup lsp-zero
			local lsp_zero = require("lsp-zero")
			-- Ensure telescope is loaded before setting keymaps
			local telescope = require("telescope.builtin")
			local lsp_attach = function(client, bufnr)
				require("twoslash-queries").attach(client, bufnr)
				lsp_highlight_document(client)
				-- Use Telescope for these LSP functions with descriptions
				vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr, desc = "Go to Definition" })
				vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr, desc = "Find References" })
				vim.keymap.set(
					"n",
					"gi",
					telescope.lsp_implementations,
					{ buffer = bufnr, desc = "Go to Implementation" }
				)
				vim.keymap.set(
					"n",
					"go",
					telescope.lsp_type_definitions,
					{ buffer = bufnr, desc = "Go to Type Definition" }
				)
				vim.keymap.set("n", "gs", telescope.lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" })

				-- Standard LSP keymaps with descriptions
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
				vim.keymap.set(
					"n",
					"gD",
					"<cmd>lua vim.lsp.buf.declaration()<cr>",
					{ buffer = bufnr, desc = "Go to Declaration" }
				)
				vim.keymap.set(
					"n",
					"<F2>",
					"<cmd>lua vim.lsp.buf.rename()<cr>",
					{ buffer = bufnr, desc = "Rename Symbol" }
				)
				vim.keymap.set(
					{ "n", "x" },
					"<F3>",
					"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
					{ buffer = bufnr, desc = "Format Document" }
				)
				vim.keymap.set(
					"n",
					"<F4>",
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					{ buffer = bufnr, desc = "Code Actions" }
				)
				vim.keymap.set(
					"n",
					"<leader>k",
					vim.lsp.buf.signature_help,
					{ desc = "LSP: Signature Documentation", buffer = buffer_number }
				)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,

				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			lsp_zero.ui({
				border = "rounded",
			})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						if server_name == "tsserver" then
							server_name = "ts_ls"
						end
						require("lspconfig")[server_name].setup({})
					end,
				},
			})

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			-- Load additional snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			local lsp_kind = require("lspkind")
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "codeium" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Confirm completion item
					["<Enter>"] = cmp.mapping.confirm({ select = true }),

					-- Trigger completion menu
					["<C-c>"] = cmp.mapping.complete(),

					-- Scroll up and down the documentation window
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					-- Navigate between snippet placeholders
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
				}),
				formatting = {
					format = lsp_kind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					}),
				},
			})
		end,
	},
}
