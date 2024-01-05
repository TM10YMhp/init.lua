return {
  "stevearc/dressing.nvim",
  -- event = "VeryLazy",
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
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
    },
    select = {
      backend = { "builtin" },
      builtin = {
        border = "single",
        max_width = 120,
        min_width = 60,
      }
    }
  }
}
