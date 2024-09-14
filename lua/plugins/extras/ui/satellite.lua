return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  opts = {
    handlers = {
      gitsigns = {
        signs = SereneNvim.config.icons.gitsigns,
      },
      marks = {
        show_builtins = true,
      },
    },
  },
}
