return {
	{
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup({})
		end
	}, {
	'gen740/SmoothCursor.nvim',
	config = function()
		require('smoothcursor').setup({cursor="▷"})
	end
} }
