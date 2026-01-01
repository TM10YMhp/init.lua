return {
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.css" },
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "astro" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "astro" } },
  },
}
