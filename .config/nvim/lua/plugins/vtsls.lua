-- lua/plugins/vtsls.lua
return {
  "yioneko/nvim-vtsls",
  dependencies = { "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local function find_tsserver_from_root(root_dir)
      -- find hoisted node_modules in monorepos
      local nm_root = util.find_node_modules_ancestor(root_dir)
      if nm_root then
        local p = util.path.join(nm_root, "node_modules", "typescript", "lib", "tsserver.js")
        if util.path.exists(p) then return p end
      end
      -- fallback: local node_modules at root_dir
      local local_p = util.path.join(root_dir, "node_modules", "typescript", "lib", "tsserver.js")
      if util.path.exists(local_p) then return local_p end
      return nil -- last resort: vtsls will use global
    end

    lspconfig.vtsls.setup({
      -- IMPORTANT: detect the same project root VS Code would
      root_dir = util.root_pattern("pnpm-workspace.yaml", "yarn.lock", ".git", "package.json", "tsconfig.json"),

      -- Force vtsls to use your workspace tsserver
      on_new_config = function(new_config, new_root_dir)
        new_config.settings = new_config.settings or {}
        new_config.settings.vtsls = new_config.settings.vtsls or {}
        new_config.settings.vtsls.tsserver = new_config.settings.vtsls.tsserver or {}
        new_config.settings.vtsls.tsserver.path = find_tsserver_from_root(new_root_dir)
      end,

      settings = {
        -- optional preferences (match VS Code defaults as you like)
        typescript = {
          inlayHints = { includeInlayParameterNameHints = "none" },
          preferences = { includePackageJsonAutoImports = "auto" },
        },
        javascript = {
          inlayHints = { includeInlayParameterNameHints = "none" },
        },
        -- vtsls-specific goodies
        vtsls = {
          enableMoveToFileCodeAction = true,
          -- you can also set:
          -- tsserver = { logVerbosity = "off", maxTsServerMemory = 4096 }
        },
      },
    })
  end,
}
