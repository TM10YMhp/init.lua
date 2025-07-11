return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    {
      "<leader>gg",
      "<cmd>G<cr>",
      desc = "Git",
    },
    -- {
    --   "<leader>gb",
    --   "<cmd>G blame --date=format:'%y.%m%d.%H%M|%S'<cr>",
    --   desc = "Git Blame",
    -- },
  },
}
