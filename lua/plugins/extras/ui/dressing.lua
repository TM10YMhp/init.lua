return {
  "stevearc/dressing.nvim",
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
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
