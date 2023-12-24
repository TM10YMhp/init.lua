return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
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
    "ojroques/nvim-osc52",
    keys = {
      {
        '<leader>y',
        function() require('osc52').copy_visual() end,
        mode = 'x'
      }
    },
    opts = {
      max_length = 0, --Maximum length of selection (0 for no limit)
      silent = false, --Disable message on successful copy
      trim = false,   --Trim text before copy
    },
    config = function(_, opts)
      -- Here is a non-exhaustive list of the status of popular terminal
      -- emulators regarding OSC52  (https://github.com/ojroques/vim-oscyank)
      --
      -- If you are using tmux, run these steps first: enabling OSC52 in tmux.
      -- Then make sure set-clipboard is set to on: set -s set-clipboard on.

      require('osc52').setup(opts)
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    keys = {
      {
        "<leader>ww",
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
}
