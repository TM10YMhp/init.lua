return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      {
        "<leader>gg",
        "<cmd>G<cr>",
        desc = "Git",
      },
      {
        "<leader>gb",
        "<cmd>G blame --date=format:'%y.%m%d.%H%M|%S'<cr>",
        desc = "Git Blame",
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
        "<cmd>botright Flogsplit -all<cr>",
        desc = "Git Log With Author",
      },
      {
        "<leader>gl",
        [[<cmd>botright Flogsplit -format=[%h]\ {%an}%d\ %s<cr>]],
        desc = "Git Log",
      },
      {
        "<leader>gL",
        [[<cmd>botright Flogsplit -all -format=[%h]\ {%an}%d\ %s<cr>]],
        desc = "Git Log All",
      },
      {
        "<leader>gf",
        "<cmd>botright Flogsplit -raw-args=--follow -path=%<cr>",
        desc = "Git Log Current File",
      },
    },
    config = function()
      vim.g.flog_default_opts = { max_count = 500 }
    end,
  },
}
