return {
  -- oil.nvim: disabled but preserved — re-enable by setting enabled = true
  -- and setting mini.files enabled = false
  {
    'stevearc/oil.nvim',
    enabled = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        -- keymaps = {
        --   ['<C-h>'] = false,
        --   ['<C-l>'] = false,
        --   ['<C-k>'] = false,
        --   ['<C-j>'] = false,
        --   ['<M-h>'] = 'actions.select_split',
        -- },
        view_options = { show_hidden = true },
      }

      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      vim.keymap.set('n', '\\', '<CMD>e .<CR>', { desc = 'Open root directory' })
    end,
  },

  -- mini.files: primary file navigator (replacing oil.nvim for trial)
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup {
        options = { show_dotfiles = true },
        mappings = { close = '<Esc>', go_in_plus = '<CR>', synchronize = 'gs' },
        windows = { preview = false },
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          vim.bo[args.data.buf_id].buftype = 'acwrite'
          vim.api.nvim_create_autocmd('BufWriteCmd', {
            buffer = args.data.buf_id,
            callback = function()
              require('mini.files').synchronize()
            end,
          })
        end,
      })

      vim.keymap.set('n', '-', function()
        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end
      end, { desc = 'Open parent directory (mini.files)' })

      vim.keymap.set('n', '\\', function()
        if not MiniFiles.close() then
          MiniFiles.open(vim.uv.cwd(), false)
        end
      end, { desc = 'Open root directory (mini.files)' })
    end,
  },

  -- neo-tree: fallback file tree view, displayed on the right
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        window = { position = 'right' },
      }

      vim.keymap.set('n', '<leader>e', ':Neotree toggle right<CR>', { desc = 'Toggle file tree (neo-tree)' })
    end,
  },
}
