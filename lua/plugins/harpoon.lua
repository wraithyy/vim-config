return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- Mapování kláves, podle toho co máš na obrázku
        vim.keymap.set("n", "<leader>ha", mark.add_file, {desc="Add file to harpoon"})
        vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu, {desc="Toggle harpoon menu"})
	vim.keymap.set("n", "<leader>hc", mark.clear_all, {desc="Clear harpoon menu"})

        vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, {desc="Navigate to harpoon file"})
        vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, {desc="Navigate to harpoon file 2"})
        vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end, {desc="Navigate to harpoon file 3"})
        vim.keymap.set("n", "<C-ů>", function() ui.nav_file(4) end, {desc="Navigate to harpoon file 4"})
    end
}
