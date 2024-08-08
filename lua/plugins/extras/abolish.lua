return {
  {
    "markonm/traces.vim",
    event = "VeryLazy",
    config = function()
      vim.g.traces_substitute_preview = 1
      vim.g.traces_abolish_integration = 1
    end,
  },
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
    keys = {
      {
        "<leader>uS",
        [[:%S///gc<left><left><left><left>]],
        desc = "Substitute Preserve Case",
      },
      {
        "<leader>uS",
        [[:S///gc<left><left><left><left>]],
        mode = "x",
        desc = "Substitute Selection Preserve Case",
      },
    },
  },
}
