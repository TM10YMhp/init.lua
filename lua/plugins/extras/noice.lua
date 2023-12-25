return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      progress = {
        throttle = 1000,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = {
        enabled = false,
      },
      hover = {
        silent = true,
      }
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
    views = {
      hover = {
        border = {
          style = "single",
          padding = { 0, 0 },
        },
        position = {
          row = 2,
          col = 2,
        }
      },
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
      },
      confirm = {
        border = {
          style = "single",
        },
      },
      mini = {
        position = {
          row = -2,
          col = 0
        },
        border = {
          style = "single"
        },
        win_options = {
          winblend = 0
        }
      }
    },
    cmdline = {
      format = {
        cmdline = { icon = ">" },
        search_down = { icon = "/" },
        search_up = { icon = "?" },
        filter = { icon = "$" },
        lua = false,
        help = false,
      },
    },
    format = {
      level = {
        icons = {
          error = "E",
          warn = "W",
          info = "I",
        },
      },
    },
    popupmenu = {
      kind_icons = false,
    },
    inc_rename = {
      cmdline = {
        format = {
          IncRename = { icon = "R" },
        },
      },
    },
  }
}
