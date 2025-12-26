return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonLog" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mason",
        callback = function() vim.opt_local.wrap = true end,
      })
    end,
    keys = {
      { "<leader>um", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts_extend = { "registries" },
    opts = {
      registries = {
        "lua:custom-registry",
        "github:mason-org/mason-registry",
      },
      ui = {
        check_outdated_packages_on_open = false,
        border = "single",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "●",
          package_pending = "-",
          package_uninstalled = "○",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    optional = true,
    dependencies = { "mason.nvim" },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = { "mason.nvim" },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    dependencies = { "mason.nvim" },
  },
}
