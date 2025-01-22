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
	lsp_highlight_document(client)

	-- local telescope = require("telescope.builtin")

	-- Keymaps for LSP functions
	local opts = { buffer = bufnr, desc = "LSP action" }
	-- vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr, desc = "Go to Definition" })
	-- vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr, desc = "Find References" })
	-- vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr, desc = "Go to Implementation" })
	-- vim.keymap.set("n", "go", telescope.lsp_type_definitions, { buffer = bufnr, desc = "Go to Type Definition" })
	-- vim.keymap.set("n", "gs"telescope, telescope.lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" })

	-- Standard LSP keymaps
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
	vim.keymap.set("n", "<leader>d", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
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
			lspconfig.eslint.setup({
				on_attach = on_attach,
			})

			-- Setup for Rust analyzer
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
			})
		end,
	},
}
