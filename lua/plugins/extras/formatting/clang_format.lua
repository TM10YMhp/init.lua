return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "clang-format" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "clang-format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },
}
