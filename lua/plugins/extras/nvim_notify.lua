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
          anchor = "SE",
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
          vim.bo.filetype == "neo-tree-popup"
        then
          if vim.api.nvim_win_get_position(0)[2] > 1 then
            local neotree_width = vim.api.nvim_win_get_width(0)
            local max_width = math.floor(vim.o.columns * 0.75)
            local bottom = vim.opt.lines:get()
              - (vim.opt.cmdheight:get() + (vim.opt.laststatus:get() > 0 and 1 or 0))
            if neotree_width < max_width and vim.bo.filetype == "neo-tree-popup" then
              if (bottom - 2) == vim.api.nvim_win_get_position(0)[1] then
                col = col - neotree_width - 1
                print("BOT")
              else
                col = col - 5 -- get the width of the neotree
                print("NOT")
              end
              vim.print({ bottom - 2, vim.api.nvim_win_get_position(0)[1] })
            else
              col = col - neotree_width - 1
            end
          end
        end

        local row = require("notify.stages.util").slot_after_previous(
          win,
          state.open_windows,
          "bottom_up"
        )

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
    fps = 3,
    -- top_down = false,
  },
  config = function(_, opts)
    require("notify").setup(opts)
    vim.notify = require("notify")
  end
}
