return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        preset = 'ghost',
        options = {
          multilines = { enabled = true },
          show_diags_only_under_cursor = false,
        },
      }
      vim.diagnostic.config { virtual_text = false }
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {
      win = { wo = { wrap = true } },
    },
    keys = {
      { '<leader>x', '<cmd>Trouble diagnostics toggle<cr>', desc = '[X]  Diagnostics (Trouble)' },
    },
  },
}
