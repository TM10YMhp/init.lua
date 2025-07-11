return {
  {
    "vim-scripts/keepcase.vim",
    keys = {
      {
        "<leader>uS",
        [[:%s//\=KeepCaseSameLen(submatch(0), "")/igc<left><left><left><left><left><left>]],
        desc = "Substitute Keep Case",
      },
      {
        "<leader>uS",
        [[:s//\=KeepCaseSameLen(submatch(0), "")/igc<left><left><left><left><left><left>]],
        mode = "x",
        desc = "Substitute Selection Keep Case",
      },
    },
  },
  {
    "justinmk/vim-ipmotion",
    keys = { "{", "}" },
    config = function() vim.g.ip_skipfold = 1 end,
  },
  {
    "romainl/vim-cool",
    event = "VeryLazy",
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    opts = {
      disabled_filetypes = { "snipe-menu", "toggleterm" },
    },
  },
  {
    "BranimirE/fix-auto-scroll.nvim",
    event = "BufLeave",
    config = true,
  },
  {
    "michaeljsmith/vim-indent-object",
    keys = {
      { "ii", mode = { "o", "v" } },
      { "ai", mode = { "o", "v" } },
      { "iI", mode = { "o", "v" } },
      { "aI", mode = { "o", "v" } },
    },
  },
}
