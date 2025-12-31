return {
  "vscode-neovim/vscode-multi-cursor.nvim",
  event = "VeryLazy",
  cond = not not vim.g.vscode,
  keys = {
    { "<leader>mn", "mciw*<Cmd>nohl<CR>", remap = true },
  },
  opts = {},
}
