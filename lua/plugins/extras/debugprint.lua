return {
  "andrewferrier/debugprint.nvim",
  -- TODO: prevent load lazy.lua
  keys = {
    { "gb", mode = { "n", "x" } },
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
