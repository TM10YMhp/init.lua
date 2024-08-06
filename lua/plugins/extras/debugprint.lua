return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>r", group = "DebugPrint" },
      },
    },
  },
  {
    "andrewferrier/debugprint.nvim",
    keys = {
      { "<leader>r", mode = { "n", "x" } },
    },
    opts = {
      keymaps = {
        normal = {
          plain_below = "<leader>rp",
          plain_above = "<leader>rP",
          variable_below = "<leader>rv",
          variable_above = "<leader>rV",
          textobj_below = "<leader>ro",
          textobj_above = "<leader>rO",
        },
        visual = {
          variable_below = "<leader>rv",
          variable_above = "<leader>rV",
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
  },
}
