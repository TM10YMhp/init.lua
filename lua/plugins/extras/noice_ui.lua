return {
  "folke/noice.nvim",
  optional = true,
  opts = {
    presets = {
      -- bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
    cmdline = {
      enabled = true,
      format = {
        cmdline = { icon = ">" },
        search_down = { icon = "/" },
        search_up = { icon = "?" },
        filter = { icon = "$" },
        lua = false,
        help = false,
      },
    },
    popupmenu = {
      enabled = true,
      kind_icons = false,
    },
    messages = { enabled = true },
    notify = { enabled = true },
    smartmove = { enabled = false },
    inc_rename = {
      cmdline = {
        format = {
          IncRename = { icon = "R" },
        },
      },
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
    views = {
      popupmenu = {
        border = {
          padding = { 0, 0 },
        },
      },
      cmdline_popupmenu = {
        view = "popupmenu",
        zindex = 200,
        border = {
          style = "single",
          padding = { 0, 0 },
        },
      },
      cmdline_output = {
        format = "details",
        view = "split",
      },
      popup = {
        border = {
          style = "single",
        },
      },
      cmdline_popup = {
        border = {
          style = "single",
          padding = { 0, 0 },
        },
        size = {
          max_width = 120
        }
      },
      confirm = {
        border = {
          style = "single",
        },
      },
    },
  }
}
