if true then
  return {}
end

-- return {
--   {
--     "zbirenbaum/copilot.lua",
--     opts = {
--       filetypes = {
--         javascript = true,
--         typescript = true,
--         lua = true,
--         yaml = false,
--         markdown = false,
--         help = false,
--         gitcommit = false,
--         gitrebase = false,
--         hgcommit = false,
--         svn = false,
--         cvs = false,
--         sh = function()
--           if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
--             -- disable for .env files
--             return false
--           end
--           return true
--         end,
--         ["."] = false,
--         ["*"] = false,
--       },
--     },
--   },
-- }
