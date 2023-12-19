return {
  {
    "romainl/vim-cool",
    event = "VeryLazy",
    config = function()
      vim.opt.hlsearch = true
    end
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    opts = { insert_mode = true }
  },
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    opts = {
      retirementAgeMins = 15,
      notificationOnAutoClose = true,
      deleteBufferWhenFileDeleted = false,
    }
  },
  {
    "epwalsh/pomo.nvim",
    cmd = { "TimerStart", "TimerRepeat" },
    opts = {
      notifiers = {
        {
          name = "Default",
          opts = {
            sticky = true,
            title_icon = "",
            text_icon = "",
          },
        },
      }
    }
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    opts = {}
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    keys = {
      {
        "<leader>w",
        function()
          local picked_window_id =
            require("window-picker").pick_window() or
            vim.api.nvim_get_current_win()

          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick Window",
      }
    },
    opts = {
      hint = "statusline-winbar",
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    config = function()
      vim.cmd("silent Sleuth")
    end
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    -- keys = {},
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
        return math.floor(vim.o.lines * 0.5)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
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
      fps = 2,
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
    end
  },
}
