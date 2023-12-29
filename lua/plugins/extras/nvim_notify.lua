return {
  {
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
          if vim.g.neo_tree_is_open then
            if vim.g.neotree_win.position == "right" then
              local width = vim.api.nvim_win_get_width(vim.g.neotree_win.winid)
              col = col - width - 1
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
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    optional = true,
    opts = function(_, opts)
      opts.event_handlers = opts.event_handlers or {}

      vim.list_extend(opts.event_handlers, {
        {
          event = "neo_tree_window_after_open",
          handler = function(args)
            vim.g.neotree_win = args
            vim.g.neo_tree_is_open = true
          end,
        },
        {
          event = "neo_tree_window_before_close",
          handler = function()
            vim.g.neo_tree_is_open = false
          end,
        }
      })
    end
  }
}
