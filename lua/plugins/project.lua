-- FIX: path problems in Windows
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
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

        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyLoad",
          callback = function(event)
            if event.data == "telescope.nvim" then
              require("telescope").load_extension("projects")
            end
          end,
        })
      end,
    },
  },
}
