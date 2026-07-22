-- Seamless ctrl+hjkl navigation between nvim splits and herdr panes.
-- The nvim half of the herdr vim-aware-nav handshake (see ~/dotfiles/bin/herdr-nav
-- and herdr issue #281). Replaces christoomey/vim-tmux-navigator, which only
-- drives tmux; nvim-tmux-navigation.lua is disabled while this is active.
--
-- Flow: press <C-h> in nvim -> try `wincmd h`; if the window didn't change we're
-- at an edge split, so hand off to herdr to focus the pane in that direction.
-- (When nvim is NOT focused, herdr-nav moves panes directly and never reaches here.)
--
-- To revert to tmux: set `enabled = false` below and re-enable nvim-tmux-navigation.lua.
local enabled = true

if enabled then
  -- Resolve herdr even if nvim's PATH lacks the mise shims.
  local herdr = vim.fn.executable 'herdr' == 1 and 'herdr'
    or (vim.env.HOME .. '/.local/share/mise/installs/herdr/latest/herdr')

  local dirs = { h = 'left', j = 'down', k = 'up', l = 'right' }

  local function nav(key)
    local before = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. key)
    if vim.api.nvim_get_current_win() == before then
      -- No nvim split that way: hand focus off to the neighbouring herdr pane.
      vim.fn.system { herdr, 'pane', 'focus', '--direction', dirs[key], '--current' }
    end
  end

  vim.api.nvim_create_user_command('HerdrNav', function(o)
    nav(o.args)
  end, { nargs = 1 })

  local map = vim.keymap.set
  for key, dir in pairs(dirs) do
    map('n', '<C-' .. key .. '>', '<cmd>HerdrNav ' .. key .. '<cr>',
      { silent = true, desc = 'Nav split / herdr pane ' .. dir })
    -- Leave terminal-mode first, then navigate.
    map('t', '<C-' .. key .. '>', [[<C-\><C-n><cmd>HerdrNav ]] .. key .. '<cr>',
      { silent = true, desc = 'Nav split / herdr pane ' .. dir })
  end
end

-- This file configures keymaps only; it registers no lazy.nvim plugin.
return {}
