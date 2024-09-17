return {
  "nvim-telescope/telescope-live-grep-args.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        live_grep_args = {},
      },
    },
  },
  keys = {
    {
      "<leader>sG",
      "<cmd>Telescope live_grep_args<cr>",
      desc = "Live Grep Args",
    },
  },
  config = function()
    require("telescope").load_extension("live_grep_args")
  end,
}
