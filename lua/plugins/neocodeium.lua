return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<tab>", function()
			require("neocodeium").accept()
		end, { desc = "Accept codeium suggestion" })
 		vim.keymap.set("i", "<A-tab>", function()
			require("neocodeium").accept_word()
		end, { desc = "Accept codeium suggestion word" })
		vim.keymap.set("i", "<A-S-tab>", function()
			require("neocodeium").accept_line()
		end, { desc = "Accept codeium suggestion line" })
		vim.keymap.set("i", "<A-c>", function()
			require("neocodeium").cycle_or_complete()
		end, { desc = "Cycle or complete codeium suggestion" })
	end,
}
