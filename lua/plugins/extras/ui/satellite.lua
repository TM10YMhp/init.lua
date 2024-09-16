return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  opts = {
    winblend = 0,
    handlers = {
      cursor = {
        priority = 10,
        symbols = { " " },
      },
      diagnostic = {
        priority = 70,
        signs = { "-", "=", "≡" },
      },
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
