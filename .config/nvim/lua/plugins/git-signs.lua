return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it blame line' })
      map('n', '<leader>gd', function()
        gitsigns.diffthis '@'
      end, { desc = '[G]it diff against last commit' })
      -- Toggles
      map('n', '<leader>ub', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show [b]lame line' })
      map('n', '<leader>ud', gitsigns.toggle_deleted, { desc = 'Toggle git show [d]eleted' })
    end,
  },
}
