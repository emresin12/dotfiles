return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- JavaScript/TypeScript
        null_ls.builtins.formatting.prettierd.with {
          -- Explicitly register method
          method = null_ls.methods.FORMATTING,
          filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.eslint_d.with {
          filetypes = { 'javascript', 'javascriptreact', 'html', 'css' },
          condition = function()
            return require('null-ls.utils').root_pattern(
              'eslint.config.js',
              -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
              '.eslintrc',
              '.eslintrc.js',
              '.eslintrc.cjs',
              '.eslintrc.yaml',
              '.eslintrc.yml',
              '.eslintrc.json',
              'package.json'
            )(vim.api.nvim_buf_get_name(0)) ~= nil
          end,
        }, -- code formatter
        null_ls.builtins.formatting.isort, -- import sorting
        null_ls.builtins.diagnostics.ruff, -- fast linter

        -- Go
        null_ls.builtins.formatting.gofmt, -- basic formatter
        null_ls.builtins.formatting.goimports, -- handles imports

        -- C
        null_ls.builtins.formatting.clang_format,
      },
      -- Format on save
      -- on_attach = function(client, bufnr)
      --   if client.supports_method 'textDocument/formatting' then
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format { timeout_ms = 2000 }
      --       end,
      --     })
      --   end
      -- end,
    }
  end,
}
