return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffviewFileHistory" },
    { "<leader>dH", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory" },
  },
  opts = {
    use_icons = false,
    signs = {
      fold_closed = ">",
      fold_open = "v",
      done = "✓",
    },
    view = {
      default = {
        layout = "diff2_vertical",
      },
      merge_tool = {
        layout = "diff3_mixed",
      },
      file_history = {
        layout = "diff2_vertical",
      },
    },
    file_panel = {
      win_config = {
        position = "right",
        width = 30,
      }
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
  }
}
