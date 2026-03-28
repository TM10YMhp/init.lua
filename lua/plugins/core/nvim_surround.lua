return {
  "kylechui/nvim-surround",
  -- event = "VeryLazy",
  init = function()
    vim.g.nvim_surround_no_mappings = true
  end,
  keys = {
    {
      "ys",
      "<Plug>(nvim-surround-normal)",
      desc = "Add a surrounding pair around a motion (normal mode)"
    },
    {
      "ds",
      "<Plug>(nvim-surround-delete)",
      desc = "Delete a surrounding pair"
    },
    {
      "cs",
      "<Plug>(nvim-surround-change)",
      desc = "Change a surrounding pair"
    },
    {
      "cS",
      "<Plug>(nvim-surround-change-line)",
      desc = "Change a surrounding pair, putting replacements on new lines"
    },
    {
      "S",
      "<Plug>(nvim-surround-visual)",
      desc = "Add a surrounding pair around a visual selection",
      mode = { "x" }
    },
    {
      "gS",
      "<Plug>(nvim-surround-visual-line)",
      desc = "Add a surrounding pair around a visual selection, on new lines",
      mode = { "x" },
    },
  },
  opts = {
    move_cursor = "sticky",
  },
}
