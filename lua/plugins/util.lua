return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        keys = {
          { "<leader>ep", "<cmd>Telescope projects<cr>", desc = "Projects" },
        },
        opts = {
          -- silent_chdir = false,
        },
        config = function(_, opts)
          require("project_nvim").setup(opts)

          vim.cmd("ProjectRoot")

          pcall(require, 'notify')
          require("tm10ymhp.utils").notify("project.nvim loaded")

          vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            callback = function(event)
              if event.data == "telescope.nvim" then
                require("telescope").load_extension("projects")
              end
            end,
          })
        end
      },
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
}
