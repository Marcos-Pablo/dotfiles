return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        -- keymaps = {
        --   ['<C-h>'] = false,
        --   ['<C-l>'] = false,
        --   ['<C-k>'] = false,
        --   ['<C-j>'] = false,
        --   ['<M-h>'] = 'actions.select_split',
        -- },
        view_options = { show_hidden = true },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      vim.keymap.set('n', '\\', '<CMD>e .<CR>', { desc = 'Open root directory' })
    end,
  },
}
