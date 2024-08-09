return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      border = "single",
      relative = "editor",
      max_width = 120,
      min_width = 60,
      win_options = {
        wrap = true,
      },
    },
    select = {
      backend = { "builtin" },
      builtin = {
        border = "single",
        max_width = 120,
        min_width = 60,
        win_options = {
          wrap = true,
        },
      },
    },
  },
}
