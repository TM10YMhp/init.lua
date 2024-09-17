return {
  "dstein64/nvim-scrollview",
  event = "VeryLazy",
  opts = {
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
    vim.api.nvim_set_hl(0, "ScrollView", { link = "CursorLine" })
    vim.api.nvim_set_hl(0, "ScrollViewCursor", { link = "Visual" })

    require("scrollview.contrib.gitsigns").setup()
    require("scrollview").setup(opts)
  end,
}
