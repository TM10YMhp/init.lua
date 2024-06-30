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
    {
      "<leader>sn",
      "<cmd>Telescope notify<cr>",
      desc = "Search Notifications",
    },
  },
  opts = {
    timeout = 3000,
    icons = {
      -- stylua: ignore start
      DEBUG = "D",
      ERROR = "E",
      INFO  = "I",
      TRACE = "T",
      WARN  = "W",
      -- stylua: ignore end
    },
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win, record)
      local config = vim.api.nvim_win_get_config(win)

      config.title = {
        {
          record.title[1],
          "Notify" .. record.level .. "Title",
        },
      }
      config.border = "single"

      vim.api.nvim_win_set_config(win, config)
    end,
    minimum_width = 28,
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
    fps = 2,
    top_down = false,
  },
  config = function(_, opts)
    require("notify").setup(opts)
    -- https://github.com/rcarriga/nvim-notify/issues/205
    vim.notify = vim.schedule_wrap(require("notify"))

    -- local banned_messages = { "No information available" }
    -- vim.notify = function(msg, ...)
    --   for _, banned in ipairs(banned_messages) do
    --     if msg == banned then
    --       return
    --     end
    --   end
    --   return require("notify")(msg, ...)
    -- end
  end,
}
