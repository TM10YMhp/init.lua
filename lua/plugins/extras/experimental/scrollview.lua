return {
  "dstein64/nvim-scrollview",
  event = "VeryLazy",
  opts = {
    excluded_filetypes = { "DiffviewFileHistory", "DiffviewFiles", "neo-tree" },
    winblend = 0,
    signs_on_startup = {
      "conflicts",
      "cursor",
      "diagnostics",
      "marks",
      "search",
    },
    cursor_symbol = "",
    cursor_priority = 100,
    search_symbol = "=",
  },
  config = function(_, opts)
    require("scrollview.contrib.gitsigns").setup()
    require("scrollview").setup(opts)
  end,
}
