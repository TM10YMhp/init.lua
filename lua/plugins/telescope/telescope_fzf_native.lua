return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function(_, opts)
      SereneNvim.on_load("telescope.nvim", function()
        require("telescope").load_extension("fzf")
      end)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    opts = {
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
  },
}
