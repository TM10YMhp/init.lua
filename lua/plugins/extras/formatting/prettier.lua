return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- stylua: ignore
      formatters_by_ft = {
        astro            = { "prettier", lsp_format = "prefer" },
        css              = { "prettier" },
        graphql          = { "prettier" },
        handlebars       = { "prettier" },
        html             = { "prettier" },
        less             = { "prettier" },
        markdown         = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        scss             = { "prettier" },
        vue              = { "prettier" },
        yaml             = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--html-whitespace-sensitivity=ignore",
          },
        },
      },
    },
  },
}
