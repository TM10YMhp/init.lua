SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    extension = {
      xaml = "xml",
    },
  })
end)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "xml", "c_sharp" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {},
      },
    },
  },
}
