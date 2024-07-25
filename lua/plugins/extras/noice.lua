return {
  "folke/noice.nvim",
  event = SereneNvim.lazy_init and "BufAdd" or "VeryLazy",
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
        throttle = 1000 / 4,
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
    routes = {
      {
        filter = { event = "lsp", kind = "progress" },
        view = "notify",
        opts = { replace = true },
      },
    },
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
  config = function(_, opts)
    -- HACK: noice redraws when it's not needed
    local mod = require("noice.util.hacks")
    mod.fix_redraw = function() end

    require("noice").setup(opts)
  end,
}
