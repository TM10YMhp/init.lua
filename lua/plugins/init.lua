return {
  {
    "rareitems/printer.nvim",
    keys = { { "<leader>cp", mode = { "n", "v" } } },
    opts = {
      keymap = "<leader>cp",
    },
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    config = function()
      require("tsc.utils").find_tsconfigs = function()
        local tsconfig = vim.fn.findfile("tsconfig.json", ".;")
        local jsconfig = vim.fn.findfile("jsconfig.json", ".;")

        if tsconfig ~= "" then
          return { tsconfig }
        end

        if jsconfig ~= "" then
          return { jsconfig }
        end

        return {}
      end

      require("tsc").setup({
        bin_path = "tsc.CMD",
        flags = { watch = true },
      })
    end,
  },
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "",
      smart_punctuators = {
        enabled = true,
        semicolon = {
          enabled = true,
          ft = { "cs", "c", "cpp", "java" },
        },
      },
    },
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
}
