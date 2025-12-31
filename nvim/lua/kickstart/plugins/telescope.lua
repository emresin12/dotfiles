return {

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', function()
        local builtin = require 'telescope.builtin'
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local offset_encoding = 'utf-8'
        for _, client in ipairs(clients) do
          if client.offset_encoding then
            offset_encoding = client.offset_encoding
            break
          end
        end
        builtin.lsp_dynamic_workspace_symbols({
          offset_encoding = offset_encoding,
        })
      end, { desc = '[S]earch Workspace Symbols' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Keymap for leader gd to show commit history and diff with the current buffer
      vim.keymap.set('n', '<leader>gd', function()
        require('telescope.builtin').git_bcommits {
          attach_mappings = function(prompt_bufnr, map)
            local actions = require 'telescope.actions'
            local action_state = require 'telescope.actions.state'

            -- Select the commit and preview the diff without modifying the buffer
            map('i', '<CR>', function()
              local commit_hash = action_state.get_selected_entry().value
              actions.close(prompt_bufnr) -- Close the Telescope picker

              -- Open Fugitive diff view for the current file against the selected commit
              vim.cmd('Gvdiffsplit ' .. commit_hash .. ':%')
            end)

            return true
          end,
        }
      end, { desc = 'View commit history and diff without modifying buffer' })

      -- Slightly advanced example of overriding default behavior and theme

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find {
          preview = true,
        }
      end, { desc = '[S]earch [/] fuzzily in current buffer' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
