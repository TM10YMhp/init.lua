return {
  "MaximilianLloyd/tw-values.nvim",
  keys = {
    { "<leader>tv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
  },
  opts = {
    border = "single", -- Valid window border style,
    show_unknown_classes = true, -- Shows the unknown classes popup
    focus_preview = true, -- Sets the preview as the current window
    copy_register = "", -- The register to copy values to,
    keymaps = {
      copy = "<leader>ty", -- Normal mode keymap to copy the CSS values between {}
    },
  },
}
