return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "sql" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "sqlfluff" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
        mysql = { "sqlfluff" },
        plsql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "--dialect=ansi", "-" },
        },
      },
    },
  },
}
