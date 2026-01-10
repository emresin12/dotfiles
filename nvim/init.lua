vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Remove Neovim's default global LSP keymaps (gr*, gO, <C-S>)
-- These are set unconditionally at startup and conflict with custom keymaps
-- Use pcall since some keymaps may not exist depending on Neovim version
for _, keymap in ipairs {
  { 'n', 'grn' },
  { 'n', 'gra' },
  { 'n', 'grr' },
  { 'n', 'gri' },
  { 'n', 'grt' },
  { 'n', 'gO' },
  { 'i', '<C-S>' },
  { 'x', 'gra' },
  { { 'x', 'o' }, 'in' },
  { { 'x', 'o' }, 'an' },
} do
  pcall(vim.keymap.del, keymap[1], keymap[2])
end

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local opts = { buffer = args.buf }
--
--     -- Delete the specific "gr" mappings
--     vim.keymap.del('n', 'gra', opts) -- Code Action
--     vim.keymap.del('n', 'grn', opts) -- Rename
--     vim.keymap.del('n', 'grr', opts) -- References
--     vim.keymap.del('i', '<C-S>', opts) -- Signature Help (if you want this gone too)
--
--     -- Note: 'grd' is not a default yet in most versions,
--     -- but you can add it here if it becomes one.
--   end,
-- })

require 'options'

require 'keymaps'

require 'lazy-bootstrap'

require 'lazy-plugins'

-- vim: ts=2 sts=2 sw=2 et
