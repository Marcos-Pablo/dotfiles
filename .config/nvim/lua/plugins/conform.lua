return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('conform').setup {
      -- Tell Conform to prefer your project's Prettier (node_modules/.bin/prettier)
      -- and fall back to a global one if needed.
      formatters = {
        prettier = { prefer_local = 'node_modules/.bin' },
      },
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        -- add others if you need them
      },
      format_on_save = {
        -- Runs only if a formatter is available for the buffer
        lsp_fallback = false,
        timeout_ms = 1000,
      },
    }

    -- Optional: manual format keymap
    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      require('conform').format { async = true }
    end, { desc = 'Format with Conform' })
  end,
}
