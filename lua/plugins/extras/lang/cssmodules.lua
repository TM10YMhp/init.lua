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
          -- on_attach = function(client)
          --   -- avoid accepting `definitionProvider` responses from this LSP
          --   client.server_capabilities.definitionProvider = false
          -- end,
        },
      },
    },
  },
}
