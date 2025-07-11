return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  init = function()
    SereneNvim.on_very_lazy(function()
      Snacks.toggle
        .new({
          name = "Treesitter Context",
          get = function() return require("treesitter-context").enabled() end,
          set = function(state)
            local ts_context = require("treesitter-context")
            if state then
              ts_context.enable()
            else
              ts_context.disable()
            end
          end,
        })
        :map("<leader>ox")
    end)
  end,
  opts = {
    enable = true,
    multiwindow = true,
    mode = "cursor",
    max_lines = 0,
  },
}
