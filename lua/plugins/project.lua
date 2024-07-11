-- FIX: path problems in Windows
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "ahmedkhalf/project.nvim",
      event = "VeryLazy",
      keys = {
        { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      },
      opts = {
        -- silent_chdir = false,
      },
      config = function(_, opts)
        require("project_nvim").setup(opts)

        vim.cmd("ProjectRoot")

        SereneNvim.on_load("telescope.nvim", function()
          require("telescope").load_extension("projects")
        end)
      end,
    },
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
