return {
  "epwalsh/pomo.nvim",
  cmd = { "TimerStart", "TimerRepeat" },
  opts = {
    notifiers = {
      {
        name = "Default",
        opts = { sticky = true, title_icon = "", text_icon = "" },
      },
    },
  },
}
