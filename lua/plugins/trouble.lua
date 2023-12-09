return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = function()
    require("trouble").setup({
      height = 15,
      icons = false,
      padding = false,
      fold_open = "-",
      fold_closed = "+",
      indent_lines = false,
      use_diagnostic_signs = true,
      auto_preview = false,
      auto_jump = {},
    })

    vim.keymap.set(
      "n",
      "<leader>ed",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      { desc = "Document Diagnostics" }
    )

    vim.keymap.set(
      "n",
      "<leader>eD",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      { desc = "Workspace Diagnostics" }
    )
  end
}
