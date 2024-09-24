return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    move_cursor = "sticky",
    keymaps = {
      insert = false,
      insert_line = false,
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "sa",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
      change_line = "cS",
    },
  },
}
