return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  cmd = {
    'ClaudeCode',
    'ClaudeCodeFocus',
    'ClaudeCodeSend',
    'ClaudeCodeTreeAdd',
    'ClaudeCodeAdd',
    'ClaudeCodeSelectModel',
    'ClaudeCodeDiffAccept',
    'ClaudeCodeDiffDeny',
  },
  keys = {
    { '<C-,>', '<cmd>ClaudeCode<cr>', mode = { 'n', 't' }, desc = 'Toggle Claude' },
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select model' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection' },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Reject diff' },
  },
  opts = {
    terminal = {
      provider = 'snacks',
      split_side = 'right',
      split_width_percentage = 0.4,
      snacks_win_opts = {
        keys = {
          claude_hide = {
            '<C-,>',
            function(self)
              self:hide()
            end,
            mode = { 'n', 't' },
            desc = 'Hide Claude',
          },
        },
      },
    },
  },
}
