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
      retirementAgeMins = 20,
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
  -- {
  --   "tpope/vim-surround",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.g.surround_indent = 0
  --   end
  -- },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
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
  },
  {
    "Darazaki/indent-o-matic",
    event = "VeryLazy",
    config = function()
      require("indent-o-matic").setup({})

      require("indent-o-matic").detect()
    end
  },
}
