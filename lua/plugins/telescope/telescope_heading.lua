return {
  "crispgm/telescope-heading.nvim",
  keys = {
    { "<leader>sm", "<cmd>Telescope heading<cr>", desc = "Heading" },
  },
  config = function()
    require("telescope").load_extension("heading")
  end,
}
