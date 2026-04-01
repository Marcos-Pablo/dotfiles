-- lua/plugins/vtsls.lua
return {
  'yioneko/nvim-vtsls',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  config = function()
    local function find_tsserver(root_dir)
      -- find hoisted node_modules in monorepos (walks upward from root_dir)
      local nm = vim.fs.find('node_modules', { path = root_dir, upward = true, type = 'directory' })
      if nm[1] then
        local p = vim.fs.joinpath(nm[1], 'typescript', 'lib', 'tsserver.js')
        if vim.uv.fs_stat(p) then return p end
      end
      -- fallback: local node_modules at root_dir
      local local_p = vim.fs.joinpath(root_dir, 'node_modules', 'typescript', 'lib', 'tsserver.js')
      if vim.uv.fs_stat(local_p) then return local_p end
    end

    vim.lsp.config('vtsls', {
      filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      root_markers = { 'pnpm-workspace.yaml', 'yarn.lock', 'tsconfig.json', 'package.json', '.git' },
      before_init = function(_, config)
        if config.root_dir then
          local tsserver_path = find_tsserver(config.root_dir)
          if tsserver_path then
            config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
              vtsls = { tsserver = { path = tsserver_path } },
            })
          end
        end
      end,
      settings = {
        typescript = {
          inlayHints = { includeInlayParameterNameHints = 'none' },
          preferences = { includePackageJsonAutoImports = 'auto' },
        },
        javascript = {
          inlayHints = { includeInlayParameterNameHints = 'none' },
        },
        vtsls = {
          enableMoveToFileCodeAction = true,
        },
      },
    })
    vim.lsp.enable('vtsls')
  end,
}
