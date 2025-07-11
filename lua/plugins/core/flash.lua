return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    -- {
    --   "s",
    --   mode = { "n", "x", "o" },
    --   function() require("flash").jump() end,
    --   desc = "Flash",
    -- },
    -- {
    --   "S",
    --   mode = { "n", "x", "o" },
    --   function() require("flash").treesitter() end,
    --   desc = "Flash Treesitter",
    -- },
    -- {
    --   "r",
    --   mode = "o",
    --   function() require("flash").remote() end,
    --   desc = "Remote Flash",
    -- },
    -- {
    --   "R",
    --   mode = { "o", "x" },
    --   function() require("flash").treesitter_search() end,
    --   desc = "Treesitter Search",
    -- },
    {
      "<c-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc = "Toggle Flash Search",
    },
  },
  ---@type Flash.Config
  opts = {
    search = {
      exclude = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
        function(win)
          -- exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
        "snacks_notif",
        "blink-cmp-menu",
      },
    },
    highlight = {
      backdrop = false,
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
        highlight = {
          backdrop = false,
        },
      },
    },
  },
}
