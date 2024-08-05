return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      triggers = {
        { "c", mode = { "n" } },
        { "d", mode = { "n" } },
        { "y", mode = { "n" } },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "cs", desc = "Change a surrounding pair" },
      {
        "cS",
        desc = "Change a surrounding pair, putting replacements on new lines",
      },
      { "ds", desc = "Delete a surrounding pair" },
      {
        "S",
        mode = "x",
        desc = "Add a surrounding pair around a visual selection",
      },
      { "ys", desc = "Add a surrounding pair around a motion (normal mode)" },
      {
        "yss",
        desc = "Add a surrounding pair around the current line (normal mode)",
      },
      {
        "ySS",
        desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
      },
      {
        "yS",
        desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
      },
      {
        "gS",
        mode = "x",
        desc = "Add a surrounding pair around a visual selection, on new lines",
      },
      {
        "<C-G>S",
        mode = "i",
        desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
      },
      {
        "<C-G>s",
        mode = "i",
        desc = "Add a surrounding pair around the cursor (insert mode)",
      },
    },
    opts = {
      move_cursor = "sticky",
    },
  },
}
