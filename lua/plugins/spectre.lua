return {
  "nvim-pack/nvim-spectre",
  keys = {
     {'<leader>r', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',mode={'n'},desc = "Replace"},
  },
  config = function()
     require('spectre').setup({ is_block_ui_break = true })
  end,
}
