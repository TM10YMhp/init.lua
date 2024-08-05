return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonLog" },
    keys = {
      { "<leader>um", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
      ui = {
        check_outdated_packages_on_open = false,
        border = "single",
        width = 90,
        height = 40,
        icons = {
          package_installed = "●",
          package_pending = "-",
          package_uninstalled = "○",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require("mason-registry")

      for _, tool in ipairs(opts.ensure_installed) do
        if not mr.is_installed(tool) then
          local p = mr.get_package(tool)
          p:install()
        end
      end
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    dependencies = { "williamboman/mason.nvim" },
  },
}
