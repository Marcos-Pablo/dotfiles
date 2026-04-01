return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      integrations = {
        mason = true,
        which_key = true,
      },
    },
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'catppuccin-mocha'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'vague2k/vague.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require('vague').setup {
        -- optional configuration here
      }
      vim.cmd 'colorscheme vague'
      require('fidget').setup {
        -- LSP progress etc. can stay default
        notification = {
          -- how notifications look
          view = {
            -- optional: keep as-is
            -- group_separator_hl = "Comment",
          },
          -- the actual floating window
          window = {
            normal_hl = 'NormalFloat', -- use your (transparent) float bg
            border = 'none', -- avoid a boxed look; try "rounded" if you like
            winblend = 0, -- no extra tint; raise to 10–20 if you want a light fade
            zindex = 60,
          },
        },
      }

      vim.opt.termguicolors = true
      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'highlight NormalNC guibg=NONE ctermbg=NONE'
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })

      -- Give popup menus a visible background (separate from NormalFloat).
      -- Uses a slightly lighter shade of the vague theme bg (#1c1c24).
      vim.api.nvim_set_hl(0, 'Pmenu',    { bg = '#252535' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#3a3a52', bold = true })
    end,
  },
}

-- return {
--   'EdenEast/nightfox.nvim',
--   name = 'nightfox',
--   priority = 1000,
--   opts = {
--     transparent = true,
--   },
--   init = function()
--     vim.cmd.colorscheme 'duskfox'
--     vim.cmd.hi 'Comment gui=none'
--   end,
-- }
