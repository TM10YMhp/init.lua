-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {},
--     },
--   },
-- }

return {
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
