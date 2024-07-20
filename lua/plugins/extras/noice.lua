return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = { enabled = false },
    messages = { enabled = false },
    popupmenu = { enabled = false },
    lsp = {
      progress = {
        throttle = 1000 / 5,
        view = "notify",
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = false },
      signature = { enabled = false },
    },
    health = { checker = false },
    throttle = 1000 / 10,
    format = {
      level = {
        icons = {
          error = "E",
          warn = "W",
          info = "I",
        },
      },
      spinner = {
        name = "toggle5",
      },
    },
    views = {
      notify = {
        replace = true,
      },
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end

    require("noice").setup(opts)
  end,
}
