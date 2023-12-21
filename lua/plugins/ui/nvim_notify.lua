return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = {
    timeout = 3000,
    icons = {
      DEBUG = "D",
      ERROR = "E",
      INFO  = "I",
      TRACE = "T",
      WARN  = "W"
    },
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win, record)
      vim.print(record)
      vim.api.nvim_win_set_config(win, {
        zindex = 100,
        border = "single",
        title = {{ record.title[1], "Notify" .. record.level .. "Border" }},
      })
    end,
    minimum_width = 30,
    stages = "no_animation",
    render = function(bufnr, notif, highlights)
      local namespace = require("notify.render.base").namespace()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

      vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        hl_group = highlights.body,
        end_line = #notif.message - 1,
        end_col = #notif.message[#notif.message],
        priority = 50,
      })
    end,
    fps = 1,
    top_down = false,
  },
  config = function(_, opts)
    require("notify").setup(opts)

    vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or {
        style = "minimal",
        border = "single",
      }
      config.focus_id = ctx.method
      if not (result and result.contents) then
        -- vim.notify('No information available')
        return
      end
      local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
      if vim.tbl_isempty(markdown_lines) then
        -- vim.notify('No information available')
        return
      end
      return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
    end

    vim.notify = require("notify")

    vim.keymap.set(
      "n",
      "<leader>Tn",
      function()
        vim.notify("test", vim.log.levels.DEBUG, { title = "DEBUG" })
        vim.notify("test", vim.log.levels.ERROR, { title = "ERROR" })
        vim.notify("test", vim.log.levels.INFO, { title = "INFO" })
        vim.notify("test", vim.log.levels.TRACE, { title = "TRACE" })
        vim.notify("test", vim.log.levels.WARN, { title = "WARN" })
        vim.notify("test", vim.log.levels.OFF, { title = "OFF" })
        vim.notify("test", vim.log.levels.DEBUG, { title = "DEBUG" })
        vim.notify("test", vim.log.levels.ERROR, { title = "ERROR" })
        vim.notify("test", vim.log.levels.INFO, { title = "INFO" })
        vim.notify("test", vim.log.levels.TRACE, { title = "TRACE" })
        vim.notify("test", vim.log.levels.WARN, { title = "WARN" })
        vim.notify("test", vim.log.levels.OFF, { title = "OFF" })
        vim.notify("test", vim.log.levels.DEBUG, { title = "DEBUG" })
        vim.notify("test", vim.log.levels.ERROR, { title = "ERROR" })
        vim.notify("test", vim.log.levels.INFO, { title = "INFO" })
        vim.notify("test", vim.log.levels.TRACE, { title = "TRACE" })
        vim.notify("test", vim.log.levels.WARN, { title = "WARN" })
        vim.notify("test", vim.log.levels.OFF, { title = "OFF" })
      end,
      { desc = "Test Notifications" }
    )
  end
}
