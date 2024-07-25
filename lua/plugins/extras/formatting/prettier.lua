return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "prettier" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- stylua: ignore
      formatters_by_ft = {
        astro            = { "prettier" },
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
          prepend_args = function(_, ctx)
            if vim.endswith(ctx.filename, ".astro") then
              return {
                "--html-whitespace-sensitivity=ignore",
                "--end-of-line=crlf",
                "--plugin=prettier-plugin-astro",
              }
            end

            return {
              "--html-whitespace-sensitivity=ignore",
              "--end-of-line=crlf",
            }
          end,
        },
      },
    },
  },
}
