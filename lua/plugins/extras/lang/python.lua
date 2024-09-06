vim.g.python_recommended_style = 0

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },
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
