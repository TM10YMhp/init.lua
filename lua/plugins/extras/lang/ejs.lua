SereneNvim.on_lazy_init(
  function()
    vim.filetype.add({
      extension = {
        ejs = "eruby",
      },
    })
  end
)

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "embedded_template" } },
  },
}
