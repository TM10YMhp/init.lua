return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts_extend = { "spec" },
  opts = {
    win = {
      no_overlap = false,
      height = { min = 4, max = 0.25 },
      border = "single",
    },
    spec = {
      { "<leader><tab>", group = "tabs" },
      { "<leader>R", group = "rest" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "diff" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>i", group = "insert" },
      { "<leader>k", group = "workspace" },
      { "<leader>l", group = "lsp/actions" },
      { "<leader>m", group = "harpoon" },
      { "<leader>o", group = "obsidian" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "toggle" },
      { "<leader>u", group = "ui" },
      { "<leader>w", group = "windows" },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "<leader>z", group = "games" },
      {
        "]d",
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next Diagnostic",
      },
      {
        "[d",
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Previous Diagnostic",
      },
    },
    icons = {
      rules = false,
      keys = {
        Up = "Up ",
        Down = "Down ",
        Left = "Left ",
        Right = "Right ",
        C = "C-",
        M = "M-",
        S = "S-",
        CR = "CR ",
        Esc = "<Esc>",
        ScrollWheelDown = "ScrollWheelDown ",
        ScrollWheelUp = "ScrollWheelUp ",
        NL = "NL ",
        BS = "<BS>",
        Space = "<Space>",
        Tab = "Tab ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },
  },
}
