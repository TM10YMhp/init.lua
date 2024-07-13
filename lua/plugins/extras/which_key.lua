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
  opts = {
    win = {
      no_overlap = false,
      row = -2,
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
    },
    icons = {
      rules = false,
      keys = {
        Up = "Up-",
        Down = "Down",
        Left = "Left-",
        Right = "Right-",
        C = "⌃",
        M = "M-",
        S = "S-",
        CR = "CR-",
        Esc = "Esc-",
        ScrollWheelDown = "ScrollWheelDown-",
        ScrollWheelUp = "ScrollWheelUp-",
        NL = "NL-",
        Space = "Space-",
        Tab = "Tab-",
      },
    },
  },
}
