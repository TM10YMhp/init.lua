return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssmodules_ls = {
          filetypes = { "javascriptreact", "typescriptreact" },
          init_options = {
            camelCase = "false",
          },
        },
      },
    },
  },
}
