return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
  },
  opts = {
    auto_preview = false,
    win = {
      wo = { wrap = true },
    },
    preview = {
      type = "split",
      relative = "win",
      position = "top",
      size = 0.3,
      wo = { foldcolumn = "0" },
    },
    icons = {
      indent = {
        top = "",
        middle = "",
        last = "",
        fold_open = "- ",
        fold_closed = "+ ",
        ws = "  ",
      },
      folder_closed = "",
      folder_open = "",
    },
  },
}
