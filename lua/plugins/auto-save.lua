return {
	"pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup {
			trigger_events = {"BufLeave", "FocusLost"}, -- Události, které spustí automatické uložení
			condition = function(buf)
				-- Kontrola, zda by měl být soubor uložen
				local fn = vim.fn
				local utils = require("auto-save.utils.data")

				if
					fn.getbufvar(buf, "&modifiable") == 1 and
					utils.not_in(fn.getbufvar(buf, "&filetype"), {}) and
					fn.getbufvar(buf, "&buftype") == ""
					then
						return true -- uložit pouze, pokud je buffer modifikovatelný
					end
					return false
				end,
				write_all_buffers = false, -- uložit pouze aktuální buffer
				debounce_delay = 135, -- zpoždění uložení v ms
			}
		end,
	}

