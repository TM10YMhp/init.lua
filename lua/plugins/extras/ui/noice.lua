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
        throttle = 1000 / 2,
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
      -- Skip validation messages from jdtls
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = vim.tbl_get(message.opts, "progress", "client")
            if client == "jdtls" then
              local content = vim.tbl_get(message.opts, "progress", "message")
              return content == "Validate documents"
            end

            return false
          end,
        },
        view = "notify",
        opts = { skip = true },
      },
      -- Replace lsp progress notifications
      {
        filter = { event = "lsp", kind = "progress" },
        view = "notify",
        opts = { replace = true, timeout = 1000 },
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
    -- HACK: noice redraws when it's not needed
    local mod = require("noice.util.hacks")
    ---@diagnostic disable-next-line: duplicate-set-field
    mod.fix_redraw = function() end

    require("noice").setup(opts)
  end,
}
