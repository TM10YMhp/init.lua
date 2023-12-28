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
        "<leader>gh",
        "<cmd>botright Flogsplit<cr>",
        desc = "Git Log With Author",
      },
      {
        "<leader>gl",
        [[<cmd>botright Flogsplit -format=[%h]\ {%an}%d\ %s<cr>]],
        desc = "Git Log",
      },
      {
        "<leader>gL",
        "<cmd>botright Flogsplit -raw-args=--follow -path=%<cr>",
        desc = "Git Log Current File",
      },
    },
  },
}
