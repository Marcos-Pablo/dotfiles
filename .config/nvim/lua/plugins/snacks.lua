return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit log' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit file history' },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    dashboard = {
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
