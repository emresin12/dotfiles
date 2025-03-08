return {
  {
    'github/copilot.vim',
    lazy = false, -- Load the plugin immediately, not lazily
    config = function()
      -- Explicitly set variables that might help initialize the status
      vim.g.copilot_no_maps = false
      vim.g.copilot_assume_mapped = false
      vim.g.copilot_tab_fallback = ''
    end,
  },
}
