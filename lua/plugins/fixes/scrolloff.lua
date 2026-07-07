return {
  -- {
  --   -- NOTE: a legacy
  --   "vim-scripts/keepcase.vim",
  --   keys = {
  --     {
  --       "<leader>uS",
  --       [[:%s//\=KeepCaseSameLen(submatch(0), "")/igc<left><left><left><left><left><left>]],
  --       desc = "Substitute Keep Case",
  --     },
  --     {
  --       "<leader>uS",
  --       [[:s//\=KeepCaseSameLen(submatch(0), "")/igc<left><left><left><left><left><left>]],
  --       mode = "x",
  --       desc = "Substitute Selection Keep Case",
  --     },
  --   },
  -- },
  -- {
  --   -- NOTE: a legacy
  --   "justinmk/vim-ipmotion",
  --   keys = { "{", "}" },
  --   config = function() vim.g.ip_skipfold = 1 end,
  -- },
  {
    -- NOTE: a legacy
    "romainl/vim-cool",
    event = "VeryLazy",
  },
  {
    -- NOTE: a fixes
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    opts = {
      -- disabled_filetypes = { "snipe-menu", "toggleterm" },
    },
  },
}
