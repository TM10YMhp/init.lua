-- TODO: WIP
return {
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts = {
      winblend = 0,
      signs_on_startup = {
        "conflicts",
        "cursor",
        "diagnostics",
        "marks",
        "search",
      },
      cursor_symbol = "",
      cursor_priority = 100,
      search_symbol = "=",
      signs_column = 0,
      signs_max_per_row = 1,
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "ScrollView", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "ScrollViewCursor", { link = "Visual" })

      require("scrollview.contrib.gitsigns").setup()
      require("scrollview").setup(opts)
    end,
  },
  -- {
  --   "lewis6991/satellite.nvim",
  --   -- event = "VeryLazy",
  --   opts = {
  --     winblend = 0,
  --     handlers = {
  --       cursor = {
  --         priority = 10,
  --         symbols = { " " },
  --       },
  --       diagnostic = {
  --         enable = false,
  --         signs = { "*" },
  --       },
  --       gitsigns = {
  --         enable = false,
  --         overlap = true,
  --         signs = SereneNvim.config.icons.gitsigns,
  --       },
  --       marks = {
  --         enable = false,
  --         show_builtins = true,
  --       },
  --       quickfix = {
  --         enable = false,
  --       },
  --       search = {
  --         enable = false,
  --       },
  --     },
  --   },
  -- },
}
