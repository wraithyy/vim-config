return {
	's1n7ax/nvim-window-picker',
	name = 'window-picker',
	event = 'VeryLazy',
	version = '2.*',
	config = function()
		require 'window-picker'.setup({
			hint = 'floating-big-letter',
			autoselect_one = true,
			include_current = false,
			filter_rules = {
				-- Nezahrnovat některá okna
				bo = {
					filetype = { 'aerial', 'qf' }, -- Vyloučení specifických typů oken
					buftype = { 'nofile' }, -- Vyloučení terminálů a dočasných bufferů
				},
			},
			other_win_hl_color = '#e35e4f',
		})
		vim.api.nvim_set_keymap('n', '<leader>w',
			'<cmd>lua vim.api.nvim_set_current_win(require("window-picker").pick_window())<CR>',
			{ noremap = true, silent = true, desc = "Pick window" })
	end
}
