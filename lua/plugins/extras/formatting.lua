return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "clang-format",
        "prettier",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        biome = function()
          return true
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- stylua: ignore
      formatters_by_ft = {
        javascript      = { "biome" },
        javascriptreact = { "biome" },
        json            = { "biome" },
        jsonc           = { "biome" },
        typescript      = { "biome" },
        typescriptreact = { "biome" },

        cs  = { "clang-format" },
        c   = { "clang-format" },
        cpp = { "clang-format" },

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
