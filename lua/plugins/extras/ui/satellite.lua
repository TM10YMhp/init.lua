return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  opts = {
    winblend = 0,
    handlers = {
      gitsigns = {
        overlap = true,
        signs = SereneNvim.config.icons.gitsigns,
      },
      marks = {
        show_builtins = true,
      },
    },
  },
}
