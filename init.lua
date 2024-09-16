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
vim.opt.guicursor = {
	"n-v-c:block", -- Normal, visual, command-line: block cursor
	"i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
	"r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
	"o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
	"a:blinkwait700-blinkoff400-blinkon250", -- All modes: blinking settings
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}
