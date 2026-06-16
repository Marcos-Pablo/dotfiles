-- Diagnostics UI.
--
-- The block below is intentional native (non-plugin) config, kept here so all
-- diagnostics-related setup lives in one file. It runs at startup because
-- lazy.nvim `require`s every file in lua/plugins/ to collect specs — which is
-- the correct time to configure diagnostics, before any are rendered.
--
-- We hide inline diagnostics (virtual_text / virtual_lines) and instead show
-- them in a floating window anchored to the top-right corner on CursorHold,
-- dismissed on cursor move / insert / buffer leave.
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
  float = {
    focusable = false,
    border = 'rounded',
    source = true,
    scope = 'line',
  },
}

local diag_float_win = nil

local function close_diag_float()
  if diag_float_win and vim.api.nvim_win_is_valid(diag_float_win) then
    pcall(vim.api.nvim_win_close, diag_float_win, true)
  end
  diag_float_win = nil
end

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if vim.api.nvim_get_mode().mode ~= 'n' then
      return
    end
    close_diag_float()
    local _, win = vim.diagnostic.open_float(nil, {
      focus = false,
      max_width = math.floor(vim.o.columns / 3),
    })
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_config(win, {
        relative = 'editor',
        anchor = 'NE',
        row = 1,
        col = vim.o.columns - 1,
      })
      diag_float_win = win
    end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CursorMoved', 'BufLeave' }, {
  callback = close_diag_float,
})

return {
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
