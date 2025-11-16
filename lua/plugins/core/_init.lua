return {
  {
    "attilarepka/header.nvim",
    cmd = { "AddLicenseGPL3", "AddLicenseWTFPL", "AddHeader" },
    keys = {
      { "<leader>ih", "<cmd>AddLicenseWTFPL<cr>", desc = "Insert Header" },
    },
    opts = {
      file_name = false,
      author = "T4PE",
      date_created = false,
      line_separator = "--------------",
      copyright_text = "Copyright 2025",
    },
    config = function(_, opts)
      require("header").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          local header = require("header")
          if header and header.update_date_modified then
            header.update_date_modified()
          else
            vim.notify_once(
              "header.update_date_modified is not available",
              vim.log.levels.WARN
            )
          end
        end,
        desc = "Update header's date modified",
      })
    end,
  },
  {
    "nvim-mini/mini.operators",
    event = "VeryLazy",
    opts = {
      evaluate = { prefix = "" },
      multiply = { prefix = "gm" },
      -- use <C-c> to cancel exchange
      exchange = { prefix = "X" },
      replace = { prefix = "" },
      sort = { prefix = "go" },
    },
  },
  {
    "nvim-mini/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode.
        left = "<M-Left>",
        right = "<M-Right>",
        down = "<M-Down>",
        up = "<M-Up>",

        -- Move current line in Normal mode
        line_left = "<M-Left>",
        line_right = "<M-Right>",
        line_down = "<M-Down>",
        line_up = "<M-Up>",
      },
      options = {
        reindent_linewise = false,
      },
    },
  },
  {
    "kevinhwang91/nvim-fundo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    config = function()
      require("fundo").setup()
      vim.api.nvim_exec_autocmds(
        "BufReadPost",
        { group = "Fundo", modeline = false }
      )
    end,
  },
  {
    "aaronik/treewalker.nvim",
    cmd = "Treewalker",
    keys = {
      {
        "<M-s>",
        "<cmd>Treewalker Down<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Down",
      },
      {
        "<M-w>",
        "<cmd>Treewalker Up<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Up",
      },
      {
        "<M-a>",
        "<cmd>Treewalker Left<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Left",
      },
      {
        "<M-d>",
        "<cmd>Treewalker Right<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Right",
      },
      {
        "<M-q>",
        "<cmd>Treewalker SwapLeft<cr>",
        desc = "Treewalker SwapLeft",
      },
      {
        "<M-e>",
        "<cmd>Treewalker SwapRight<cr>",
        desc = "Treewalker SwapRight",
      },
    },
    opts = {
      highlight = false,
    },
  },
  {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    opts = {
      on_tab_options = {
        ["expandtab"] = false,
        ["tabstop"] = vim.o.tabstop,
        ["shiftwidth"] = 0,
      },
      on_space_options = {
        ["expandtab"] = true,
        ["tabstop"] = vim.o.tabstop,
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    },
    config = function(_, opts)
      require("guess-indent").setup(opts)
      require("guess-indent").set_from_buffer(nil, true, true)
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
}
