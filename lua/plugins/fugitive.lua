return {
  {
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
  },
  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Flog", "Flogsplit", "Floggit" },
    keys = {
      {
        "<leader>gl",
        "<cmd>Flogsplit<cr>",
        desc = "Git Log",
      },
      {
        "<leader>gL",
        "<cmd>Flogsplit -raw-args=--follow -path=%<cr>",
        desc = "Git Log Curent File",
      },
    },
  },
}
