return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")

		local project_files = function()
			local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
			if ret == 0 then
				builtin.git_files()
			else
				builtin.find_files()
			end
		end
		vim.keymap.set("n", "<leader>ff", project_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find text in files" })
		vim.keymap.set("n", "<leader>fr", function()
			require("telescope.builtin").lsp_references()
		end, { desc = "Find references", noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").lsp_definitions()
		end, { desc = "Find definitions", noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gb", function()
			require("telescope.builtin").git_branches()
		end, { desc = "Find git branches", noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"<leader>?",
			require("telescope.builtin").oldfiles,
			{ desc = "[?] Find recently opened files" }
		)
		vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Git Stashes", noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fx", builtin.treesitter, { desc = "Find text in treesitter" })
	end,
}
