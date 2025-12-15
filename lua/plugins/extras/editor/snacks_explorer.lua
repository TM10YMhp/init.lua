return {
  "folke/snacks.nvim",
  opts = {
    explorer = {},
  },
  keys = {
    {
      "<leader>ee",
      function()
        Snacks.explorer({ cwd = vim.fn.getcwd() })
      end,
      desc = "Explorer Snacks (root)",
    },
    {
      "<leader>eE",
      function()
        Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer Snacks (dir)",
    },
  },
}
