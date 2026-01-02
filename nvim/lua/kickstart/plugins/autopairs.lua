-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {
      map_cr = false,
      fast_wrap = {
        map = '<M-e>',
      },
    }
  end,
}
