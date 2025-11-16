return {
  "r0nsha/multinput.nvim",
  init = function()
    SereneNvim.on_very_lazy(function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "multinput.nvim" } })
        return vim.ui.input(...)
      end
    end)
  end,
  opts = {},
}
