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
        null_ls.builtins.formatting.prettier, -- for JS/TS/JSON/CSS/HTML
        null_ls.builtins.diagnostics.eslint, -- for JS/TS linting

        -- Python
        null_ls.builtins.formatting.black, -- code formatter
        null_ls.builtins.formatting.isort, -- import sorting
        null_ls.builtins.diagnostics.ruff, -- fast linter

        -- Go
        null_ls.builtins.formatting.gofmt, -- basic formatter
        null_ls.builtins.formatting.goimports, -- handles imports

        -- C
        null_ls.builtins.formatting.clang_format,
      },
      -- Format on save
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { timeout_ms = 2000 }
            end,
          })
        end
      end,
    }
  end,
}
