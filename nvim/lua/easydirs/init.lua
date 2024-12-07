local log = require('plenary.log'):new()
log.level = 'debug'
-- plugin/project_dirs.lua
local M = {}

-- Store marked directories
M.marked_dirs = {}

-- Data file path
local data_path = vim.fn.stdpath 'data' .. '/project_dirs.json'

-- Load saved directories
local function load_dirs()
  local file = io.open(data_path, 'r')
  if file then
    local content = file:read '*all'
    file:close()
    M.marked_dirs = vim.fn.json_decode(content) or {}
  end
end

-- Save directories
local function save_dirs()
  local file = io.open(data_path, 'w')
  if file then
    file:write(vim.fn.json_encode(M.marked_dirs))
    file:close()
  end
end

-- Function to mark a directory
function M.mark_directory()
  local cwd = vim.fn.getcwd()
  if not vim.tbl_contains(M.marked_dirs, cwd) then
    table.insert(M.marked_dirs, cwd)
    save_dirs()
    print('Marked directory: ' .. cwd)
  end
end

-- Function to remove a marked directory
function M.unmark_directory()
  local cwd = vim.fn.getcwd()
  for i, dir in ipairs(M.marked_dirs) do
    if dir == cwd then
      table.remove(M.marked_dirs, i)
      save_dirs()
      print('Unmarked directory: ' .. cwd)
      return
    end
  end
end

-- Function to show marked directories in Telescope
function M.show_marked_dirs()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local themes = require 'telescope.themes'

  local function remove_dir(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local dir = selection.path

    -- Remove from marked_dirs
    for i, marked_dir in ipairs(M.marked_dirs) do
      if marked_dir == dir then
        table.remove(M.marked_dirs, i)
        save_dirs()
        print('Unmarkd directory: ' .. dir)
        break
      end
    end

    -- Update picker with new results
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    current_picker:refresh(
      finders.new_table {
        results = M.marked_dirs,
        entry_maker = function(entry)
          return {
            ordinal = entry,
            display = vim.fn.fnamemodify(entry, ':t'),
            path = entry,
          }
        end,
      },
      { reset_prompt = true }
    )
  end

  local dropdown_theme = themes.get_dropdown()

  pickers
    .new(dropdown_theme, {
      prompt_title = 'Marked Directories',
      finder = finders.new_table {
        results = M.marked_dirs,
        entry_maker = function(entry)
          return {
            ordinal = entry,
            display = vim.fn.fnamemodify(entry, ':t'),
            path = entry,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        -- Add remove mapping for both x and ctrl-x
        map('i', '<c-x>', remove_dir) -- ctrl-x in insert mode
        map('n', 'x', remove_dir) -- x in normal mode

        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()

          -- change directory to selected path
          vim.cmd.cd(selection.path)
          -- clear buffer
          vim.cmd 'bufdo bwipeout'
          print('Changed to project: ' .. selection.display)
        end)
        return true
      end,
    })
    :find()
end
-- Setup function
-- Setup function with keymaps
function M.setup(opts)
  opts = opts or {}
  local default_opts = {
    keymaps = {
      mark_directory = '<leader>pm', -- (p)roject (m)ark
      unmark_directory = '<leader>pu', -- (p)roject (u)nmark
      show_marked_dirs = '<leader>pp', -- (p)roject (p)ick
    },
  }

  -- Merge user options with defaults
  opts = vim.tbl_deep_extend('force', default_opts, opts)

  -- Load saved directories on startup
  load_dirs()

  -- Create commands
  vim.api.nvim_create_user_command('MarkDirectory', M.mark_directory, {})
  vim.api.nvim_create_user_command('UnmarkDirectory', M.unmark_directory, {})
  vim.api.nvim_create_user_command('ShowMarkedDirs', M.show_marked_dirs, {})

  -- Set keymaps
  vim.keymap.set('n', opts.keymaps.mark_directory, M.mark_directory, { desc = 'Mark current directory' })
  vim.keymap.set('n', opts.keymaps.unmark_directory, M.unmark_directory, { desc = 'Unmark current directory' })
  vim.keymap.set('n', opts.keymaps.show_marked_dirs, M.show_marked_dirs, { desc = 'Show marked directories' })
end
return M
