print("Ahoj Wraithy")
require("config.lazy")
require("config.remap")
vim.cmd("colorscheme catppuccin-mocha")
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
]])
