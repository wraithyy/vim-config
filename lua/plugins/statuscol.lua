return {
	-- 	"luukvbaal/statuscol.nvim",
	-- 	dependencies = { "lewis6991/gitsigns.nvim" },
	-- 	config = function()
	-- 		local builtin = require("statuscol.builtin")
	-- 		require("statuscol").setup({
	-- 			-- configuration goes here, for example:
	-- 			relculright = false,
	-- 			segments = {
	-- 				--				{
	-- 				--					text = { "▷" },
	-- 				--					condition = {
	-- 				--						function(args) -- shown only for the current window
	-- 				--							return vim.api.nvim_win_get_cursor(0)[1] == args.lnum
	-- 				--						end,
	-- 				--					},
	-- 				--					sign = { wrap = true },
	-- 				--				},
	--
	-- 				{
	-- 					sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = false },
	-- 					click = "v:lua.ScSa",
	-- 				},
	-- 				{
	-- 					text = {
	-- 						function(args)
	-- 							for _, mark in ipairs(vim.fn.getmarklist(args.buf)) do
	-- 								if mark.pos[2] == args.lnum then
	-- 									return mark.mark:sub(-1)
	-- 								end
	-- 							end
	-- 							return ""
	-- 						end,
	-- 					},
	-- 					hl = "MarkSignHL",
	-- 					click = "v:lua.ScSa",
	-- 				},
	-- 				{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
	--
	-- 				{ sign = { namespace = { "gitsigns" }, wrap = true }, click = "v:lua.ScSa" },
	-- 			},
	-- 		})
	-- 	end,
	--
	-- }
}
