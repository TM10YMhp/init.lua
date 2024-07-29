return {
  {
    "debugloop/telescope-undo.nvim",
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
    },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      extensions = {
        undo = {
          use_delta = false,
        },
      },
    },
  },
}
