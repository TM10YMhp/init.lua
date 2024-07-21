return {
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
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "php-cs-fixer",
        "blade-formatter",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
        php = { "php_cs_fixer" },
      },
      formatters = {
        ["blade-formatter"] = {
          prepend_args = {
            "--indent-inner-html",
            "--extra-liners=''",
          },
        },
      },
    },
  },
}
