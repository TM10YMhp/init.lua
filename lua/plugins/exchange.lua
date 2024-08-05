return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      triggers = {
        { "c", mode = { "n" } },
      },
    },
  },
  {
    "tommcdo/vim-exchange",
    keys = {
      { "X", desc = "Exchange", mode = "x" },
      { "cx", desc = "Exchange" },
      { "cxc", desc = "Exchange Clear" },
      { "cxx", desc = "Exchange Line" },
    },
  },
}
