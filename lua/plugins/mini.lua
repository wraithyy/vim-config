return {

	{
		"echasnovski/mini.map",
		version = "*", -- použijte poslední stabilní verzi
		config = function()
			local map = require("mini.map")
			local diagnostic_integration = map.gen_integration.diagnostic({
				error = "TinyInlineDiagnosticVirtualTextError",
				warn = "TinyInlineDiagnosticVirtualTextWarn",
				info = "TinyInlineDiagnosticVirtualTextInfo",
				hint = "TinyInlineDiagnosticVirtualTextHint",
			})
			map.setup({
				-- Základní konfigurace
				integrations = {
					map.gen_integration.builtin_search(),
					-- map.gen_integration.diff(),
					diagnostic_integration,
					map.gen_integration.gitsigns(),
				},
				symbols = {
					encode = map.gen_encode_symbols.dot("4x2"), -- Značky pro zobrazení
				},
				window = {
					show_integration_count = false,
					side = "right", -- Zobrazení mapy na pravé straně
					width = 20, -- Šířka mapy
					winblend = 0,
				},
			})
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = map.open,
			})

			vim.api.nvim_create_autocmd("WinClosed", {
				callback = map.refresh,
			})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = function()
					local _, col = unpack(vim.api.nvim_win_get_cursor(0))
					local width = vim.api.nvim_win_get_width(0)
					if width - col < 20 then
						MiniMap.close()
					else
						MiniMap.open()
					end
				end,
			})
		end,
	},
	{
		"echasnovski/mini.tabline",
		version = false,
		config = function()
			require("mini.tabline").setup({})
			vim.api.nvim_set_hl(0, "MiniTablineCurrent", {
				bg = "#1E1E2E",
				cterm = {
					bold = true,
					italic = true,
					underline = true,
				},
				italic = true,
				sp = "#00e8c6",
			})
		end,
	},
}
