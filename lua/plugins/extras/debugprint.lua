return {
  "andrewferrier/debugprint.nvim",
  keys = {
    "gbp",
    "gbP",
    "gbv",
    "gbV",
    "gbo",
    "gbO",
    { "gbv", mode = "x" },
    { "gbV", mode = "x" },
  },
  opts = {
    keymaps = {
      normal = {
        plain_below = "gbp",
        plain_above = "gbP",
        variable_below = "gbv",
        variable_above = "gbV",
        textobj_below = "gbo",
        textobj_above = "gbO",
      },
      visual = {
        variable_below = "gbv",
        variable_above = "gbV",
      },
    },
    commands = {
      toggle_comment_debug_prints = nil,
      delete_debug_prints = nil,
    },
    display_counter = false,
    display_snippet = false,
    print_tag = "::",
  },
}
