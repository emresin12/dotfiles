return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
          lualine_b = {
            {
              'filename',
              {
                function()
                  local head = vim.b.gitsigns_head
                  if vim.b.gitsigns_status_dict then
                    -- Show the commit hash if in diff mode
                    return 'Diffing against: ' .. (head or 'Working Tree')
                  end
                  return 'Commit: ' .. (head or 'N/A')
                end,
                icon = '', -- Git icon to indicate the file version
              },
              'branch',
            },
          },
          lualine_c = {
            'diff',
          },
          lualine_x = {},
          lualine_y = { 'diagnostics', 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
}
