return {
    "Equilibris/nx.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local nx = require('nx')

      nx.setup({
        nx_cmd_root = "npx nx",  -- Set the command root
        command_runner =  require('nx.command-runners').toggleterm_runner({c})
      })

      -- Keybinding to open Telescope for nx actions
      vim.api.nvim_set_keymap(
        'n',
        '<leader>nx',
        '<cmd>Telescope nx actions<CR>',
        { noremap = true, silent = true, desc = 'Open nx actions' }
      )
    end,
  }
