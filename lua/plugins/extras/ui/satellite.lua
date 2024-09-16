-- TODO: replace
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
        enable = false,
        priority = 100,
        signs = { "-", "=", "≡" },
      },
      gitsigns = {
        overlap = true,
        signs = SereneNvim.config.icons.gitsigns,
      },
      marks = {
        enable = false,
        show_builtins = true,
      },
    },
  },
}
