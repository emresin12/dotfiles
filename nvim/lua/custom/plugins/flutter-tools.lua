return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      return {
        lsp = {
          capabilities = capabilities,
          -- Explicitly set offset_encoding to utf-8 for Neovim 0.11 compatibility
          ---@diagnostic disable-next-line: assign-type-mismatch
          offset_encoding = 'utf-8',
        },
      }
    end,
  },
}
