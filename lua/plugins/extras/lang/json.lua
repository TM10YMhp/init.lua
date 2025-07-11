return {
  { "b0o/SchemaStore.nvim", lazy = true },
  {
    "nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "json5" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "jsonls" } },
  },
}
