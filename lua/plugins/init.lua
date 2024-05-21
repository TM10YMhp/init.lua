return {
  {
    "folke/ts-comments.nvim",
    keys = {
      {
        "gc",
        function()
          return require("vim._comment").operator()
        end,
        expr = true,
        mode = { "n", "x" },
        desc = "Toggle comment",
      },
      {
        "gcc",
        function()
          return require("vim._comment").operator() .. "_"
        end,
        expr = true,
        desc = "Toggle comment line",
      },
      {
        "gc",
        function()
          require("vim._comment").textobject()
        end,
        mode = { "o" },
        desc = "Comment textobject",
      },
    },
    opts = {},
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
    config = function()
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
    config = function()
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
