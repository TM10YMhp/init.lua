vim.g.python_recommended_style = 0

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "basedpyright" } },
  },
}
