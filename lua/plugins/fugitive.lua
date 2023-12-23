return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    {
      "<leader>gb",
      ":G blame<cr>",
      mode = { "n", "x" },
      desc = "Git Blame"
    },
  },
}
