return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    {
      "<leader>ed",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "Document Diagnostics"
    },
    {
      "<leader>eD",
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
