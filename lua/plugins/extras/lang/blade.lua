return {
  {
    "folke/ts-comments.nvim",
    optional = true,
    opts = {
      lang = {
        blade = "{{-- %s --}}",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
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

      vim.list_extend(opts.ensure_installed, { "blade", "php", "php_only" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "blade-formatter" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
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
