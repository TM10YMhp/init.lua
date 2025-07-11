return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "intelephense" } },
  },
}
