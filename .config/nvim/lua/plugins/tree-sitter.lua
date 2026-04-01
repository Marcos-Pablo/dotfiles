return { -- Parser manager for Neovim's built-in treesitter
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    local ts = require('nvim-treesitter')
    local ts_config = require('nvim-treesitter.config')

    -- Cache installed and available parsers to avoid filesystem hits on every FileType event
    local installed = {}
    local available = {}
    local function refresh_installed()
      installed = ts_config.get_installed()
    end
    refresh_installed()
    available = ts.get_available()

    -- Replaces auto_install = true: install missing parsers on demand and start highlighting.
    -- Skips filetypes with no parser in nvim-treesitter's registry (e.g. harpoon, oil).
    -- If a parser is mid-install, pcall fails silently and treesitter works on next open.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then return end
        if not vim.tbl_contains(available, lang) then return end

        if not vim.tbl_contains(installed, lang) then
          ts.install({ lang })
          refresh_installed()
        end

        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Pre-install common parsers at startup
    require('nvim-treesitter').install({
      'astro', 'bash', 'c', 'cpp', 'diff', 'dockerfile',
      'git_config', 'gitignore', 'go', 'html', 'javascript',
      'json', 'lua', 'luadoc', 'make', 'markdown', 'markdown_inline',
      'query', 'typescript', 'vim', 'vimdoc', 'yaml',
    })
  end,
}
