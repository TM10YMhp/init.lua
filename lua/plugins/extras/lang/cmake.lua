return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "cmake" } },
  },
}
