return {
  "dstein64/vim-startuptime",
  cmd = "StartupTime",
  config = function()
    vim.g.startuptime_tries = 10
    vim.g.startuptime_event_width = 30
  end,
}
