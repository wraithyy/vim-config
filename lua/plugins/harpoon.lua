return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependecies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values
		-- Mapování kláves, podle toho co máš na obrázku
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
			{ desc = "Toggle harpoon menu" })
		vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Clear harpoon menu" })

		vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end,
			{ desc = "Navigate to harpoon file" })
		vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end,
			{ desc = "Navigate to harpoon file" })
		vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end,
			{ desc = "Navigate to harpoon file" })
		vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end,
			{ desc = "Navigate to harpoon file" })
	end
}
