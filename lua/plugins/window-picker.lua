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
					filetype = { 'NvimTree', 'notify', 'aerial', 'Outline', 'Trouble' },
					--buftype = { 'nofile' },
					buftype = {},
				},
			},
			other_win_hl_color = '#e35e4f',
		})
		local function pick_window()
			local picked_window = require("window-picker").pick_window()
			if picked_window then
				vim.api.nvim_set_current_win(picked_window)
			end
		end
		vim.keymap.set('n', '<leader>w', pick_window, {
			noremap = true,
			silent = true,
			desc = "Pick window",
		})
		--		vim.api.nvim_set_keymap('n', '<leader>w',
		--			'<cmd>lua vim.api.nvim_set_current_win(require("window-picker").pick_window())<CR>',
		--			{ noremap = true, silent = true, desc = "Pick window" })
	end
}
