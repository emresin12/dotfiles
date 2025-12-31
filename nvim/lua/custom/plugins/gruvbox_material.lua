return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = 'hard'

      vim.cmd.colorscheme 'gruvbox-material'

      -- Make unused variables appear faded
      local function set_diagnostic_highlights()
        local faded = '#7c6f64'
        -- DiagnosticUnnecessary for diagnostic system
        vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = faded, italic = true })
        -- LSP semantic token modifier for "unnecessary" (unused variables/imports)
        vim.api.nvim_set_hl(0, '@lsp.mod.unnecessary', { fg = faded, italic = true })
      end

      set_diagnostic_highlights()

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = set_diagnostic_highlights,
      })
    end,
  },
}
