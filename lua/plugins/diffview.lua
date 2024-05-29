return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
    {
      "<leader>dh",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "DiffviewFileHistory",
    },
    {
      "<leader>dH",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "DiffviewFileHistory",
    },
  },
  opts = {
    use_icons = false,
    signs = {
      fold_closed = "> ",
      fold_open = "v ",
      done = "✓",
    },
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
    file_panel = {
      win_config = {
        position = "bottom",
        height = 16,
      },
    },
    hooks = {
      diff_buf_read = function()
        vim.opt_local.wrap = true
        vim.opt_local.list = false
      end,
    },
    keymaps = {
      view = {
        ["[x"] = false,
        ["]x"] = false,
      },
      file_panel = {
        ["[x"] = false,
        ["]x"] = false,
      },
    },
  },
}
