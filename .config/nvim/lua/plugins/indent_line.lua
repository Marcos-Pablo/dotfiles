return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = function(_, opts)
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3d3d52' })
      require('ibl').setup(opts)
    end,
    opts = {
      scope = { enabled = false },
      indent = {
        char = '▎',
        tab_char = '▎',
        highlight = { 'IblIndent' },
      },
    },
  },
}
