return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      -- silent_chdir = false,
    },
    config = function(_, opts)
      -- HACK: check if directory exists
      local M = require("project_nvim.utils.path")
      local superclass_exists = M.exists
      ---@diagnostic disable-next-line: duplicate-set-field
      function M.exists(path)
        path = path:gsub("\\", "/")
        return vim.fn.isdirectory(path) == 1 or superclass_exists(path)
      end

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
