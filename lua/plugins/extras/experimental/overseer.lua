return {
  "stevearc/overseer.nvim",
  dependencies = { "toggleterm.nvim" },
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  keys = {
    { "<leader>t", "", desc = "+term/tasks" },
    { "<leader>tw", "<cmd>OverseerToggle<cr>", desc = "Task list" },
    { "<leader>to", "<cmd>OverseerRun<cr>", desc = "Run task" },
    {
      "<leader>tq",
      "<cmd>OverseerQuickAction<cr>",
      desc = "Action recent task",
    },
    { "<leader>ti", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
    { "<leader>tb", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
    { "<leader>tt", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    { "<leader>tc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
  },
  opts = {
    strategy = "toggleterm",
    dap = false,
    task_list = {
      direction = "right",
      bindings = {
        ["["] = false,
        ["]"] = false,
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    },
    form = {
      border = "single",
    },
    confirm = {
      border = "single",
    },
    task_win = {
      border = "single",
    },
    help_win = {
      border = "single",
    },
  },
}
