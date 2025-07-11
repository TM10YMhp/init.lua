return {
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "jsdoc",
        "tsx",
        "typescript",
      },
    },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "ts_ls" } },
  },
}
