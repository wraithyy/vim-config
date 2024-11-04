print("Ahoj Wraithy")
require("config.lazy")
require("config.highlight_on_yank")
require("config.autoroot")
require("config.remap")
require("config.diagnostics-design")
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus,unnamed"
vim.opt.wrap = false
vim.cmd([[

  autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
]])
vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Start Alpha when vim is opened with no arguments",
	group = group_name,
	callback = function()
		local should_skip = false
		if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
			should_skip = true
		else
			for _, arg in pairs(vim.v.argv) do
				if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
					should_skip = true
					break
				end
			end
		end
		if not should_skip then
			require("alpha").start(true, require("alpha").default_config)
		end
	end,
})
vim.opt.guicursor = {
	"n-v-c:block", -- Normal, visual, command-line: block cursor
	"i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
	"r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
	"o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
	"a:blinkwait700-blinkoff400-blinkon250", -- All modes: blinking settings
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}
