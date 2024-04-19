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
    },
  },
  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Flog", "Flogsplit", "Floggit" },
    init = function()
      vim.g.flog_default_opts = {
        max_count = 1000,
      }
    end,
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
  },
  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    keys = {
      {
        "<leader>gB",
        "<cmd>BlameToggle window<cr>",
        desc = "Git Blame Window",
      },
      {
        "<leader>gb",
        "<cmd>BlameToggle virtual<cr>",
        desc = "Git Blame Virtual",
      },
    },
    opts = {
      date_format = "%y.%m%d.%H%M|%S",
    },
  },
}
