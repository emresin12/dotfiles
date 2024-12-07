return {
  {
    dir = vim.fn.expand '~' .. '/.config/nvim/lua/easydir', -- Using `dir` to point to the local directory
    config = function()
      return require('easydirs.init').setup()
    end,
  },
}
