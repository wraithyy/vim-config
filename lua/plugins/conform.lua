return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>j",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
					if err then
						vim.notify("Formatting error: " .. err, vim.log.levels.ERROR)
					else
						vim.notify("Formatted ", vim.log.levels.INFO)
					end
				end)
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = setmetatable({
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			typescript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			json = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			jsonc = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			css = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			scss = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
			sh = { "shfmt" },
		}, {
			__index = function(_, filetype)
				local util = require("conform.util")

				-- Zkontroluje, zda je v projektu `biome.json` nebo `biome` v `package.json`
				local has_biome = util.root_file({ "biome.json", "package.json" }, function(path)
					if vim.fn.filereadable(path) == 1 then
						local content = vim.fn.readfile(path)
						return vim.tbl_contains(content, '"biome"') or vim.fn.fnamemodify(path, ":t") == "biome.json"
					end
					return false
				end)

				-- Pokud je nalezen Biome, použijeme ho pro formátování
				if has_biome then
					return { "biome" }
				end

				-- Jinak použijeme ESLint + Prettier (fallback)
				local eslint_config = util.root_file({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.json",
					"package.json",
				}, function(path)
					if vim.fn.filereadable(path) == 1 then
						local content = vim.fn.readfile(path)
						return vim.tbl_contains(content, '"eslintConfig"') or vim.tbl_contains(content, '"eslint"')
					end
					return false
				end)

				if eslint_config then
					return { "prettierd", "prettier", "eslint_d", stop_after_first = true }
				else
					return { "prettierd", "prettier" }
				end
			end,
		}),
		format_on_save = { timeout_ms = 500 },
		formatters = {
			biome = {
				command = "biome",
				args = { "format", "--stdin-file-path", "$FILENAME" },
				stdin = true,
			},
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
