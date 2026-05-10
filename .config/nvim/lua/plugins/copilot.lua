return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = false, -- handled by the super-tab mapping below so <Tab> falls back when Copilot is disabled
            accept_word = '<C-w>',
            accept_line = '<C-j>',
            next = '<C-.>',
            prev = '<C-,>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      }

      vim.keymap.set('i', '<Tab>', function()
        local ok, suggestion = pcall(require, 'copilot.suggestion')
        if ok and suggestion.is_visible() then
          suggestion.accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
      end, { desc = 'Copilot accept or insert tab' })
    end,
    opts = {
      filetypes = {
        javascript = true,
        typescript = true,
        lua = true,
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
        ['.'] = false,
        ['*'] = false,
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    enabled = false, -- test-driving native ghost text; flip back to re-enable cmp source
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      window = {
        width = 0.4,
        height = 0.4,
      },
    },
    keys = {
      { '<leader>zm', ':CopilotChatModels<CR>', mode = 'n', desc = 'Select Models' },
      { '<leader>zc', ':CopilotChat<CR>', mode = { 'n', 'v' }, desc = 'Chat with Copilot' },
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<leader>zg', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
