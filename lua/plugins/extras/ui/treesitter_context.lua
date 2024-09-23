return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    {
      "<leader>ut",
      "<cmd>TSContextToggle<cr>",
      desc = "Toggle Treesitter Context",
    },
  },
  opts = {
    mode = "cursor",
    max_lines = 3,
  },
}
