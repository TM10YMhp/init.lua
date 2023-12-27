return {
  "folke/noice.nvim",
  event = { "LspAttach", "InsertEnter" },
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    cmdline = { enabled = false },
    messages = { enabled = false },
    popupmenu = { enabled = false },
    notify = { enabled = false },
    smartmove = { enabled = false },
    lsp = {
      progress = {
        throttle = 3000,
        view = "notify"
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
    format = {
      level = {
        icons = {
          error = "E",
          warn = "W",
          info = "I",
        },
      },
      spinner = {
        name = "balloon"
      }
    },
    views = {
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
      },
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
    }
  }
}
