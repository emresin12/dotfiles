-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Quick Fix Operations

-- Quickfix navigation
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', ':cprevious<CR>', { desc = 'Previous quickfix item' })
vim.keymap.set('n', ']Q', ':clast<CR>', { desc = 'Last quickfix item' })
vim.keymap.set('n', '[Q', ':cfirst<CR>', { desc = 'First quickfix item' })

-- Quickfix window toggle
vim.keymap.set('n', '<leader>qf', ':copen<CR>', { desc = 'Open quickfix window' })
vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Custom Mappings
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>h', '0')
vim.keymap.set('n', '<leader>l', '$')

vim.keymap.set('v', '<leader>h', '0')
vim.keymap.set('v', '<leader>l', '$')

vim.keymap.set('n', '<leader>ww', function()
  -- Run the diff command first
  vim.cmd ':w !git diff --no-index -- % -'

  vim.cmd 'write'
end, { silent = true })

vim.keymap.set('n', '<leader>wq', function()
  -- Run the diff command first
  vim.cmd ':w !git diff --no-index -- % -'

  vim.cmd 'confirm quit'
end, { silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '[j', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })

vim.keymap.set('v', '[j', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })
