-- FIX: path problems in Windows
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
      event = "VeryLazy",
      -- TODO: check this
      -- event = vim.fn.argc(-1) == 0 and "BufLeave" or "VeryLazy",
      keys = {
        { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      },
      config = function()
        require("project_nvim").setup({
          -- silent_chdir = false,
        })

        vim.cmd("ProjectRoot")

        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyLoad",
          callback = function(event)
            if event.data == "telescope.nvim" then
              require("telescope").load_extension("projects")
            end
            return true
          end,
        })
      end,
    },
  },
}
