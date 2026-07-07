return {
  {
    "nvim-mini/mini.input",
    init = function()
      SereneNvim.on_very_lazy(function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "mini.input" } })
          return vim.ui.input(...)
        end
      end)
    end,
    opts = {
      scope = "cursor",
    },
  },
  {
    "nvim-mini/mini.notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>sn",
        function() MiniNotify.show_history() end,
        desc = "Notification History",
      },
    },
    opts = function()
      local function dim(value, min, max, parent)
        min = math.floor(min < 1 and (parent * min) or min)
        max = math.floor(max < 1 and (parent * max) or max)
        return math.min(max, math.max(min, value))
      end

      local buffer_dimensions = function(buf_id)
        local line_widths =
          vim.tbl_map(vim.fn.strdisplaywidth, vim.api.nvim_buf_get_lines(buf_id, 0, -1, true))

        -- Compute width so as to fit all lines
        local width = 1
        for _, l_w in ipairs(line_widths) do
          width = math.max(width, l_w)
        end
        -- - Limit from above for better visuals
        width = dim(width, 28, 0.7, vim.o.columns)

        -- Compute height based on the width so as to fit all lines with 'wrap' on
        local height = 0
        for _, l_w in ipairs(line_widths) do
          height = height + math.floor(math.max(l_w - 1, 0) / width) + 1
        end

        return width, height
      end

      local win_config = function(buf_id)
        local has_statusline = vim.o.laststatus > 0
        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
        local width, height = buffer_dimensions(buf_id)
        return {
          anchor = "SE",
          col = vim.o.columns,
          row = vim.o.lines - pad,
          width = width,
          height = height,
        }
      end

      return {
        -- content = {
        --   format = function(notif) return notif.msg end,
        -- },
        window = {
          config = win_config,
          max_width_share = 0.7,
        },
      }
    end,
  },
}
