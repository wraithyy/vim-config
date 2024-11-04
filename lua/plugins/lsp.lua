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

local on_attach = function(client, bufnr)
	require("twoslash-queries").attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" },
	}, bufnr)
	lsp_highlight_document(client)

	local telescope = require("telescope.builtin")

	-- Keymaps for LSP functions
	local opts = { buffer = bufnr, desc = "LSP action" }
	vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr, desc = "Go to Definition" })
	vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr, desc = "Find References" })
	vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr, desc = "Go to Implementation" })
	vim.keymap.set("n", "go", telescope.lsp_type_definitions, { buffer = bufnr, desc = "Go to Type Definition" })
	vim.keymap.set("n", "gs", telescope.lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" })

	-- Standard LSP keymaps
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
	vim.keymap.set({ "n", "x" }, "<F3>", function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = "Format Document" })
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
end

return {
	-- Mason setup for installing LSP servers
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "rust_analyzer" },
			})
		end,
	},

	-- Native LSP configuration using nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Setup for TypeScript server
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
			})

			-- Setup for Rust analyzer
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
			})
		end,
	},

	-- Completion engine setup using nvim-cmp
	{

		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-c>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-f>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end),
					["<C-b>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = true,
				},
			})
			-- Setup for command line completion
			cmp.setup.cmdline("/", {
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	-- Additional plugins

	{
		"ray-x/lsp_signature.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
