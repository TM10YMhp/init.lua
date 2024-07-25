return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add blade support
      local parser_config =
        require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "blade",
        "php",
      })
    end,
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
