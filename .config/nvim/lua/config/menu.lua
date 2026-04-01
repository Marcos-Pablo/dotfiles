-- Extend Neovim 0.12's built-in PopUp menu with extra items.
-- The built-in menu (vim/_core/defaults.lua) already handles Go to definition,
-- Diagnostics, Cut/Copy/Paste, Open in browser, and LSP enable/disable logic.
vim.cmd [[
  anoremenu PopUp.References  <cmd>Telescope lsp_references<CR>
  nnoremenu PopUp.Back        <C-t>
]]
