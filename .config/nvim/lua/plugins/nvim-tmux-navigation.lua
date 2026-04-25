return {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local map = vim.keymap.set
    map('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Go to the left pane' })
    map('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Go to the down pane' })
    map('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Go to the up pane' })
    map('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Go to the right pane' })
    map('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Go to the previous pane' })
    map('t', '<C-h>', [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]], { desc = 'Go to the left pane' })
    map('t', '<C-j>', [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]], { desc = 'Go to the down pane' })
    map('t', '<C-k>', [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]], { desc = 'Go to the up pane' })
    map('t', '<C-l>', [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]], { desc = 'Go to the right pane' })
    map('t', '<C-\\>', [[<C-\><C-n><cmd>TmuxNavigatePrevious<cr>]], { desc = 'Go to the previous pane' })
  end,
}
