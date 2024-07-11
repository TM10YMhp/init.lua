return {
  "debugloop/telescope-undo.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        undo = { use_delta = false },
      },
    },
  },
  keys = {
    { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
  },
  config = function()
    require("telescope").load_extension("undo")
  end,
}
