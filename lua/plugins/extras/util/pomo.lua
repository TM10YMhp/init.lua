return {
  "epwalsh/pomo.nvim",
  cmd = { "TimerStart", "TimerRepeat" },
  dependencies = { "rcarriga/nvim-notify" },
  opts = {
    notifiers = {
      {
        name = "Default",
        opts = {
          sticky = true,
          title_icon = "",
          text_icon = "",
        },
      },
    },
  },
}
