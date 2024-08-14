-- ~/.config/nvim/lua/plugins/lsp-zero-config.lua
-- ~/.config/nvim/lua/plugins/lsp-zero-config.lua

return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'rafamadriz/friendly-snippets' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' }, -- Required

			-- Telescope for fuzzy finding
			{ 'nvim-telescope/telescope.nvim',    dependencies = { 'nvim-lua/plenary.nvim' } },
		},
		config = function()
			-- Setup lsp-zero
			local lsp_zero = require('lsp-zero')

			-- Ensure telescope is loaded before setting keymaps
			local telescope = require("telescope.builtin")
			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr }

				-- Use Telescope for these LSP functions with descriptions
				vim.keymap.set('n', 'gd', telescope.lsp_definitions,
					{ buffer = bufnr, desc = 'Go to Definition' })
				vim.keymap.set('n', 'gr', telescope.lsp_references,
					{ buffer = bufnr, desc = 'Find References' })
				vim.keymap.set('n', 'gi', telescope.lsp_implementations,
					{ buffer = bufnr, desc = 'Go to Implementation' })
				vim.keymap.set('n', 'go', telescope.lsp_type_definitions,
					{ buffer = bufnr, desc = 'Go to Type Definition' })
				vim.keymap.set('n', 'gs', telescope.lsp_document_symbols,
					{ buffer = bufnr, desc = 'Document Symbols' })

				-- Standard LSP keymaps with descriptions
				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
					{ buffer = bufnr, desc = 'Hover Documentation' })
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
					{ buffer = bufnr, desc = 'Go to Declaration' })
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',
					{ buffer = bufnr, desc = 'Rename Symbol' })
				vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
					{ buffer = bufnr, desc = 'Format Document' })
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',
					{ buffer = bufnr, desc = 'Code Actions' })
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				float_border = 'rounded',
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
			})

			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				}
			})

			local cmp = require('cmp')
			local cmp_action = lsp_zero.cmp_action()

			-- Load additional snippets
			require('luasnip.loaders.from_vscode').lazy_load()

			cmp.setup({
				sources = {
					{ name = 'path' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip', keyword_length = 2 },
					{ name = 'buffer',  keyword_length = 3 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Confirm completion item
					['<Enter>'] = cmp.mapping.confirm({ select = true }),

					-- Trigger completion menu
					['<C-Space>'] = cmp.mapping.complete(),

					-- Scroll up and down the documentation window
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),

					-- Navigate between snippet placeholders
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),
				}),
				formatting = lsp_zero.cmp_format({ details = true }),
			})
		end,
	}
}
