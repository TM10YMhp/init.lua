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
      vim.cmd("Sleuth")
    end
  },
}
