return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  opts = {
    progress = {
      poll_rate = 2,
      display = {
        done_ttl = 0,
        progress_icon = {
          pattern = "dots_ellipsis", period = 2
        }
      },
    },
    notification = {
      poll_rate = 2,
      window = {
        winblend = 0,
        border = "single"
      }
    }
  }
}
