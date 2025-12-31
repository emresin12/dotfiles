return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      -- Simple and easy statusline.
      -- require('mini.statusline').setup({ use_icons = vim.g.have_nerd_font })

      -- Better commenting
      require('mini.comment').setup()

      -- Better move
      require('mini.move').setup()

      -- Better icons
      -- require('mini.icons').setup()
    end,
  },
}
