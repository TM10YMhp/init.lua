return {
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
