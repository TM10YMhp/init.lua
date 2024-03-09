return {
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = function()
      local core = {
        name = "core",
        opts = { defer = false },
        disable = function()
          vim.opt_local.cursorline = false
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.number = false
          vim.opt_local.signcolumn = "no"
          vim.b.isbigfile = true

          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            desc = "Restore events",
            callback = function()
              if not vim.b.isbigfile then
                vim.opt.eventignore = ""
              else
                vim.opt.eventignore =
                  "CursorHold,CursorHoldI,CursorMoved,CursorMovedI,WinScrolled,FileType"
              end
            end,
          })
        end,
      }

      return {
        filesize = 1,
        features = {
          core,
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      }
    end,
  },
  {
    "tpope/vim-eunuch",
    -- stylua: ignore
    cmd = {
      "Unlink",
      "Remove",
      "Delete",
      "Move", "Rename", "Copy", "Duplicate",
      "Chmod",
      "Mkdir",
      "Cfind", "Clocate",
      "Lfind", "Llocate",
      "SudoWrite",
      "SudoEdit",
      "Wall", "W",
    },
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    config = function()
      vim.cmd("silent Sleuth")
    end,
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = {
      { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git Messenger" },
    },
    init = function()
      vim.g.git_messenger_floating_win_opts = {
        border = "single",
        row = 1,
        col = 1,
        style = "minimal",
        relative = "cursor",
      }
      vim.g.git_messenger_popup_content_margins = false
      vim.g.git_messenger_no_default_mappings = true
      vim.g.git_messenger_include_diff = "current"
      vim.g.git_messenger_max_popup_width = 80
      vim.g.git_messenger_max_popup_height = 40
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "romainl/vim-cool",
    event = "CursorMoved",
    config = function()
      vim.opt.hlsearch = true
    end,
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = "CursorMoved",
    opts = { insert_mode = true },
  },
  {
    "epwalsh/pomo.nvim",
    cmd = { "TimerStart", "TimerRepeat" },
    opts = {
      notifiers = {
        {
          name = "Default",
          opts = { sticky = true, title_icon = "", text_icon = "" },
        },
      },
    },
  },
  {
    "ojroques/nvim-osc52",
    keys = {
      {
        "<leader>y",
        function()
          require("osc52").copy_visual()
        end,
        mode = "x",
      },
    },
    opts = {
      max_length = 0, --Maximum length of selection (0 for no limit)
      silent = false, --Disable message on successful copy
      trim = false, --Trim text before copy
    },
    config = function(_, opts)
      -- Here is a non-exhaustive list of the status of popular terminal
      -- emulators regarding OSC52  (https://github.com/ojroques/vim-oscyank)
      --
      -- If you are using tmux, run these steps first: enabling OSC52 in tmux.
      -- Then make sure set-clipboard is set to on: set -s set-clipboard on.

      require("osc52").setup(opts)
    end,
  },
}
