return {
    "mbbill/undotree",
    config = function()
        -- Klávesová zkratka pro otevření/zavření Undotree
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

        -- Případně další konfigurace
    end
}
