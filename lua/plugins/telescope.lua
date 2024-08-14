return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc="Find files"})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc="Find buffers"})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="Find help"})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Find text in files"})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ")})
		end,{desc="Grep string"})
		vim.keymap.set('n', '<leader>fr', function() require('telescope.builtin').lsp_references() end, {desc="Find references", noremap = true, silent = true })
	end
}



