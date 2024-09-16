return {
	{
		'nvim-telescope/telescope-ui-select.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim'
		},
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup({


				pickers = {
					git_branches = {
						mappings = {
							i = { ["<cr>"] = actions.git_track_branch },
						},
					},
				},
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown({
							-- Volitelné: Konfigurace pro dropdown styl
							-- např. změna velikosti, okrajů, atd.
						})
					}
				}
			})

			-- Načtení rozšíření ui-select
			require('telescope').load_extension('ui-select')
		end
	}
}
