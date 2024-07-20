return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoQuickFix", "TodoTrouble", "TodoLocList" },
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
    },
    opts = {
      signs = false,
      keywords = {
        FIX = { icon = "F" },
        TODO = { icon = "T" },
        HACK = { icon = "H" },
        WARN = { icon = "W" },
        PERF = { icon = "P" },
        NOTE = { icon = "N" },
        TEST = { icon = "T" },
      },
      highlight = {
        keyword = "",
        after = "",
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden",
          "--trim",
          -- windows path separator
          "--path-separator",
          "/",
        },
      },
    },
  },
}
