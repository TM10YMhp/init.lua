return {
  {
    "antosha417/nvim-lsp-file-operations",
    opts = {
      timeout_ms = 5000,
    },
  },
  {
    "nvim-tree.lua",
    optional = true,
    dependencies = { "nvim-lsp-file-operations" },
  },
  {
    "neo-tree.nvim",
    optional = true,
    dependencies = { "nvim-lsp-file-operations" },
  },
}
