return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          root_dir = function(pattern)
            local util = require("lspconfig.util")

            -- HACK: path is not consistent across platforms
            -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/intelephense.lua#L8
            local cwd = vim.uv.cwd():gsub("\\", "/")
            local root = util.root_pattern("composer.json", ".git")(pattern)

            -- prefer cwd if root is a descendant
            return util.path.is_descendant(cwd, root) and cwd or root
          end,
        },
      },
    },
  },
}
