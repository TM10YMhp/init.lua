return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    {
      "<leader>xx",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "Document Diagnostics"
    },
    {
      "<leader>xX",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      desc = "Workspace Diagnostics"
    },
  },
  opts = {
    height = 15,
    icons = false,
    padding = false,
    fold_open = "-",
    fold_closed = "+",
    indent_lines = false,
    use_diagnostic_signs = true,
    auto_preview = false,
    auto_jump = {},
  }
}
