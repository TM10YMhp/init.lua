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
    timeout = 6000,
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
      vim.api.nvim_win_set_config(win, {
        title = {{ record.title[1], "Notify" .. record.level .. "Border" }},
      })
    end,
    minimum_width = 30,
    -- stages = "no_animation",
    stages = {
      function(state)
        local next_height = state.message.height + 2
        local next_row = require("notify.stages.util").available_slot(
          state.open_windows,
          next_height,
          "bottom_up"
        )
        if not next_row then
          return nil
        end
        return {
          relative = "editor",
          anchor = "NE",
          width = state.message.width,
          height = state.message.height,
          col = vim.opt.columns:get(),
          row = next_row,
          border = "single",
          style = "minimal",
        }
      end,
      function(state, win)
        local col = vim.opt.columns:get()
        if
          vim.bo.filetype == "neo-tree" or
          vim.bo.filetype == "neo-tree-popup" and
          vim.api.nvim_win_get_width(0) < col
        then
          col = 0
        end

        local row = require("notify.stages.util").slot_after_previous(
          win,
          state.open_windows,
          "bottom_up"
        )
        -- if vim.bo.filetype == "neo-tree-popup" then
        --   -- local row = require("notify.stages.util").available_slot(
        --   --   state.open_windows,
        --   --   next_height,
        --   --   "bottom_up"
        --   -- )
        --   local win_row = vim.api.nvim_win_get_position(win)[1]
        --   print(row, win_row)
        --   if not ((win_row - 1) == (row - 1)) then
        --     row = win_row
        --   else
        --     row = win_row - 1
        --   end
        -- end

        return {
          col = col,
          time = true,
          row = row,
        }
      end,
    },
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
    -- fps = 2,
    -- top_down = false,
  },
  config = function(_, opts)
    require("notify").setup(opts)
    vim.notify = require("notify")
  end
}
