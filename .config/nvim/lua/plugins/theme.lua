-- Switch themes by changing this value.
-- Available: 'vague', 'tokyonight'
local active_theme = 'tokyonight'

-- Shared transparent-background highlights applied after any theme loads.
local function apply_transparency()
  vim.opt.termguicolors = true
  vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
  vim.cmd 'highlight NormalNC guibg=NONE ctermbg=NONE'
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,
  },

  {
    'vague2k/vague.nvim',
    lazy = active_theme ~= 'vague',
    priority = 1000,
    config = function()
      require('vague').setup {}
      vim.cmd 'colorscheme vague'

      require('fidget').setup {
        notification = {
          window = {
            normal_hl = 'NormalFloat',
            border = 'none',
            winblend = 0,
            zindex = 60,
          },
        },
      }

      apply_transparency()
      vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#252535' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#3a3a52', bold = true })
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = active_theme ~= 'tokyonight',
    priority = 1000,
    opts = {
      style = 'moon', -- 'storm', 'moon', 'night', 'day'
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd 'colorscheme tokyonight'

      require('fidget').setup {
        notification = {
          window = {
            normal_hl = 'NormalFloat',
            border = 'none',
            winblend = 0,
            zindex = 60,
          },
        },
      }

      apply_transparency()
      vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#1e2030' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#2f334d', bold = true })
    end,
  },
}
