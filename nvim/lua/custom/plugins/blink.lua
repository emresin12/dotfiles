return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading blink.cmp is not recommended
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- On linuix, if you use a release tag, you also need to set the binary path
    -- opts_extend = { "sources.completion.enabled_providers" }

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return not vim.tbl_contains({ 'TelescopePrompt' }, vim.bo.filetype)
          and vim.bo.buftype ~= 'prompt'
      end,
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full list of options
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your colorscheme doesn't support blink.cmp yet
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'nerd font mono' or 'normal' for 'nerd font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Experimental signature help support
      signature = { enabled = true },
    },
  },
}
