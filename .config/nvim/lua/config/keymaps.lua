-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set('n', '<leader>jq', ':%!jq .<cr>', { desc = 'Format JSON' })

vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Buffer: copy paths of the current buffer / close the buffer
vim.keymap.set('n', '<leader>bp', function()
  local p = vim.fn.expand '%:.' -- relative to cwd
  vim.fn.setreg('+', p)
  vim.notify('Copied: ' .. p)
end, { desc = 'Yank relative path' })

vim.keymap.set('n', '<leader>bP', function()
  local p = vim.fn.expand '%:p' -- absolute
  vim.fn.setreg('+', p)
  vim.notify('Copied: ' .. p)
end, { desc = 'Yank absolute path' })

vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete buffer' })
