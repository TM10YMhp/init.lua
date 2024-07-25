return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cmake = {
          settings = {
            CMake = {
              filetypes = {
                "make",
                "CMakeLists.txt",
              },
            },
          },
        },
      },
    },
  },
}
