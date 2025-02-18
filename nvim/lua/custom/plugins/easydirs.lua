return {
  {
    dir = vim.fn.expand '~' .. '/.config/nvim/lua/easydirs', -- Using `dir` to point to the local directory
    config = function()
      return require('easydirs.init').setup()
    end,
  },
}
