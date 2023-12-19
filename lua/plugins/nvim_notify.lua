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
    on_open = function(win)
      vim.api.nvim_win_set_config(win, {
        zindex = 100,
        border = "single",
      })
    end,
    minimum_width = 30,
    stages = "static",
    -- render = "simple",
    fps = 1,
    top_down = false,
  },
  config = function(_, opts)
    require("notify").setup(opts)

    vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or {
        style = "minimal",
        border = "single",
        anchor = "SE"
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
  end
}
