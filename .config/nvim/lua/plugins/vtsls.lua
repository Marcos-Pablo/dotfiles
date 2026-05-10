-- lua/plugins/vtsls.lua
return {
  'yioneko/nvim-vtsls',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  config = function()
    vim.lsp.config('vtsls', {
      filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      root_markers = { 'pnpm-workspace.yaml', 'yarn.lock', 'tsconfig.json', 'package.json', '.git' },
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
          autoUseWorkspaceTsdk = true,
        },
      },
    })
    vim.lsp.enable('vtsls')
  end,
}