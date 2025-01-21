return {
	{
		"rcarriga/nvim-notify",
		config = function()
			-- Konfigurace nvim-notify
			require("notify").setup({
				-- Volitelné: Konfigurace vzhledu a chování
				stages = "fade_in_slide_out", -- Efekt zobrazení
				timeout = 2000, -- Doba zobrazení notifikace v milisekundách
				max_width = 50, -- Maximalní čkačka pro zobrazení textu
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})

			-- Nastavení nvim-notify jako výchozího pro notifikace
			vim.notify = require("notify")
		end,
	},
	-- {
	-- 	"mrded/nvim-lsp-notify",
	-- 	dependencies = {
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	config = function()
	-- 		require("lsp-notify").setup({})
	-- 	end,
	-- },
}
