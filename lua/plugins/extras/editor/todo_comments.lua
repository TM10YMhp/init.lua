return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoQuickFix", "TodoTrouble", "TodoLocList" },
    keys = {
      {
        "]t",
        function() require("todo-comments").jump_next() end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function() require("todo-comments").jump_prev() end,
        desc = "Previous todo comment",
      },
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
          "--glob=!.git",
          -- windows path separator
          "--path-separator",
          "/",
        },
      },
    },
  },
  -- {
  --   "telescope.nvim",
  --   optional = true,
  --   keys = {
  --     { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
  --   }
  -- },
  -- {
  --   "fzf-lua",
  --   optional = true,
  --   keys = {
  --     {
  --       "<leader>st",
  --       function()
  --         require("todo-comments.fzf").todo({ multiline = false })
  --       end,
  --       desc = "Fzf Todo",
  --     },
  --     -- {
  --     --   "<leader>sT",
  --     --   function()
  --     --     require("todo-comments.fzf").todo({
  --     --       keywords = { "TODO", "FIX", "FIXME" },
  --     --     })
  --     --   end,
  --     --   desc = "Todo/Fix/Fixme",
  --     -- },
  --   },
  -- },
}
