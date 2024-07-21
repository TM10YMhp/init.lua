return {
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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "biome" },
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
      },
    },
  },
}
