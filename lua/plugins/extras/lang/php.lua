-- TODO: check devsense-php-ls
-- https://github.com/neovim/nvim-lspconfig/pull/3966

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "intelephense" } },
  },
}
