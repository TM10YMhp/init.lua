return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                --diagnosticMode = "openFilesOnly",
                --typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
