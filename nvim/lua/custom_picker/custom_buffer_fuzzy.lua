local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local make_entry = require 'telescope.make_entry'
local action_state = require 'telescope.actions.state'
local action_set = require 'telescope.actions.set'

-- Make sure we require all needed modules at the top
local telescope = require 'telescope'
local previewers = require 'telescope.previewers'
local from_entry = require 'telescope.from_entry'
local conf = require('telescope.config').values
local putils = require 'telescope.previewers.utils'

function printTableRecursive(t, indent)
  indent = indent or ''
  for k, v in pairs(t) do
    if type(v) == 'table' then
      print(indent .. k .. ':')
      printTableRecursive(v, indent .. '  ')
    else
      print(indent .. k .. ': ' .. tostring(v))
    end
  end
end

local custom_buffer_fuzzy_find = function(opts)
  opts = opts or {}
  -- Default to current buffer if none specified
  opts.bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  -- All actions are on the current buffer
  local filename = vim.api.nvim_buf_get_name(opts.bufnr)
  local filetype = vim.api.nvim_buf_get_option(opts.bufnr, 'filetype')

  local highlighter = require('telescope.previewers.utils').highlighter
  highlighter(opts.bufnr, filetype, opts)

  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local lines_with_numbers = {}
  printTableRecursive(lines)

  for lnum, line in ipairs(lines) do
    table.insert(lines_with_numbers, {
      lnum = lnum,
      bufnr = opts.bufnr,
      filename = filename,
      text = line,
    })
  end

  local ts_ok, ts_parsers = pcall(require, 'nvim-treesitter.parsers')
  if ts_ok then
    filetype = ts_parsers.ft_to_lang(filetype)
  end

  -- Create and configure picker
  pickers
    .new(opts, {
      prompt_title = 'Custom Buffer Fuzzy',
      finder = finders.new_table {
        results = lines_with_numbers,
        entry_maker = opts.entry_maker or make_entry.gen_from_buffer_lines(opts),
      },
      sorter = conf.generic_sorter(opts),
      previewer = opts.previewer or conf.grep_previewer(opts),
      attach_mappings = function()
        action_set.select:enhance {
          post = function()
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
          end,
        }
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end

return custom_buffer_fuzzy_find
