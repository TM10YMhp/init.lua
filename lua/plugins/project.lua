return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      -- silent_chdir = false,
    },
    config = function(_, opts)
      SereneNvim.hacks.project()

      require("project_nvim").setup(opts)

      vim.cmd("ProjectRoot")

      SereneNvim.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
    dependencies = { "ahmedkhalf/project.nvim" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    dependencies = { "ahmedkhalf/project.nvim" },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = { "ahmedkhalf/project.nvim" },
  },
}
