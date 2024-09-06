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
          revision = "dead019eeabe612da7fb325caf72fdc7c744d19a",
        },
        filetype = "blade",
      }

      vim.list_extend(opts.ensure_installed, { "blade", "php", "php_only" })
    end,
  },
}
