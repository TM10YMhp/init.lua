require("mason").setup({
  ui = {
    check_outdated_packages_on_open = false,
    border = "single",
    width = 90,
    height = 40,
    icons = {
      package_installed = "●",
      package_pending = "-",
      package_uninstalled = "○"
    }
  }
})
require("mason-lspconfig").setup()
