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
    "ThePrimeagen/vim-be-good",
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    config = function()
      require("window-picker").setup({
        hint = "statusline-winbar",
      })

      local function pick_window()
        local picked_window_id =
          require("window-picker").pick_window() or
          vim.api.nvim_get_current_win()

        vim.api.nvim_set_current_win(picked_window_id)
      end

      vim.keymap.set(
        "n",
        "<leader>w",
        pick_window,
        { desc = "Pick Window" }
      )
    end
  },
}
